# RPvdsEx Circuit Design Guidelines for Software Integration

To successfully link a TDT hardware circuit (`.rcx` or `.rco`) to software like MATLAB, specific components and naming rules must be followed within the RPvdsEx design.

## 1. Parameter Tags (The Software Bridge)
Parameter Tags are the primary way software "sees" or "sets" values inside the DSP.
*   **Naming**: Tag names are **case-sensitive** and have a maximum length of **32 characters**.
*   **Component Selection**: Use the `ParTag` (Parameter Tag) component. Place it to the left of a component to create an *Input* (software sets value) or to the right to create an *Output* (software reads value).
*   **Linking to Signal Inputs**: Software tags **cannot** connect directly to the signal input ports (top-right of components). You must first route the tag through a `ConstF` (for floats) or `ConstI` (for integers) component.

## 2. Buffer Retrieval (Recording Data)
For recording EEG or high-speed data to the PC, you must use Buffer components.
*   **Component Choice**: Use `SerialBuf` or `MCSerStore` (multi-channel).
*   **The Data Tag**: The buffer must have a named **Data Tag** (e.g., `EEGData`). This is the string you pass to `ReadTagV` in MATLAB.
*   **The Write Pointer**: To know how much data has been recorded, you must connect the `Index` output of the buffer to a `ParTag` (e.g., `EEGIndex`). MATLAB reads this value to determine the stopping point for retrieval.
*   **Interleaving**: Multi-channel buffers (like `MCSerStore`) store data in an interleaved fashion ([Ch1_S1, Ch2_S1, ... ChN_S1]). Your software must be prepared to `reshape` this vector.

## 3. Software Triggers
To start an experiment from MATLAB, you need a way to pulse the circuit.
*   **Component**: Use the `TrgIn` component.
*   **Configuration**: Set the `Src` parameter of the `TrgIn` to **"Software"**. 
*   **Software Call**: In MATLAB, `RP.SoftTrg(N)` will send a pulse to the `TrgIn` component configured for software trigger `N` (1-10).

## 4. Data Types and Units
*   **Color Coding**: 
    *   **Teal**: Floating Point (use `ConstF`, `ReadTagV` expects 'F32').
    *   **Dark Green**: Integer (use `ConstI`, `ReadTagV` expects 'I32').
*   **Voltage Scaling**: Most hardware converters (ADC/DAC) operate on a **+/- 10V** range. Ensure your software signals are scaled appropriately before being written to hardware buffers.

## 5. Circuit Compile and Settlement
*   **Halt before Load**: Always ensure the hardware is halted (`RP.Halt`) before loading a new circuit.
*   **Initialization Delay**: After loading a circuit (`RP.LoadCOF`), wait at least **1 second** in your software before querying tag sizes or writing data. The hardware needs time to initialize memory allocations.
