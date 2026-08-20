classdef TDEVProxy < handle
% TDEVProxy  Wraps TDEV/TDevAcc to expose the same interface as RPco.X.
%
% When OpenWorkbench is running it owns the RX8 hardware. RPco.X cannot
% connect without calling ClearCOF, which destroys the Workbench session.
% TDEVProxy lets all existing code (play_signal_multi, TX_*_create_signal,
% BehavioralMain, etc.) continue calling RP.SetTagVal / RP.WriteTagV /
% RP.SoftTrg / etc. without any changes — the calls are routed through
% TDevAcc to RX8_1 while Workbench keeps hardware ownership.
%
% Usage (automatic via Circuit_Loader):
%   RP = Circuit_Loader('GB', 1, circuitPath);   % returns TDEVProxy if Workbench detected
%
% Usage (manual):
%   addpath('C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive');
%   RP = TDEVProxy(TDEV());
%
% To also get the TDEV handle for EEG recording (td.record / td.idle):
%   [RP, td] = TDEVProxy.createWithTDEV();

    properties (Access = public)
        td          % TDEV instance — expose so callers can call td.record(), td.idle()
    end

    properties (Access = private)
        soundDev    % 'RX8_1'
    end

    methods (Static)
        function [proxy, td] = createWithTDEV()
            % Convenience factory: returns both the proxy and the TDEV handle.
            addpath('C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive');
            td    = TDEV();
            proxy = TDEVProxy(td);
        end
    end

    methods
        function obj = TDEVProxy(td)
            obj.td        = td;
            obj.soundDev  = 'RX8_1';
        end

        % ------------------------------------------------------------------
        % RPco.X interface — scalar tag read/write
        % ------------------------------------------------------------------
        function SetTagVal(obj, tag, value)
            obj.td.TD.SetTargetVal([obj.soundDev '.' tag], value);
        end

        function val = GetTagVal(obj, tag)
            val = obj.td.TD.GetTargetVal([obj.soundDev '.' tag]);
        end

        function n = GetTagSize(obj, tag)
            n = obj.td.TD.GetTargetSize([obj.soundDev '.' tag]);
        end

        % ------------------------------------------------------------------
        % Buffer read/write
        % ------------------------------------------------------------------
        function WriteTagV(obj, tag, offset, data)
            % Match RPco.X WriteTagV signature: (tag, offset, data)
            obj.td.TD.WriteTargetVEX([obj.soundDev '.' tag], offset, 'F32', data(:)');
        end

        function data = ReadTagV(obj, tag, offset, n)
            data = obj.td.TD.ReadTargetVEX([obj.soundDev '.' tag], offset, n, 'F32', 'F32');
        end

        % ------------------------------------------------------------------
        % Device info
        % ------------------------------------------------------------------
        function fs = GetSFreq(obj)
            fs = obj.td.TD.GetDeviceSF(obj.soundDev);
        end

        function status = GetStatus(obj)
            % RPco.X status: bit1=connected, bit2=loaded, bit3=running.
            % In Workbench mode the circuit is already running — return 7.
            status = 7;
        end

        % ------------------------------------------------------------------
        % Trigger
        % ------------------------------------------------------------------
        function SoftTrg(obj, n)
            % Map RPco.X SoftTrg(N) to the z-tag software trigger mechanism
            % exposed on RX8_1 via TDevAcc.
            % zSwNum selects the trigger number; a 0→1→0 pulse on zSwCount fires it.
            obj.td.TD.SetTargetVal([obj.soundDev '.zSwNum'],   n);
            obj.td.TD.SetTargetVal([obj.soundDev '.zSwCount'], 1);
            pause(0.005);
            obj.td.TD.SetTargetVal([obj.soundDev '.zSwCount'], 0);
        end

        % ------------------------------------------------------------------
        % Lifecycle — no-ops in Workbench mode
        % ------------------------------------------------------------------
        function Halt(obj) %#ok<MANU>
            % Workbench manages the run state; halting here would drop the session.
        end

        function ClearCOF(obj) %#ok<MANU>
            % Never clear the COF while Workbench owns the hardware.
        end

        function Run(obj) %#ok<MANU>
            % Circuit is already running under Workbench.
        end

        % ------------------------------------------------------------------
        % EEG convenience wrappers (delegates to td)
        % ------------------------------------------------------------------
        function record(obj)
            obj.td.standby();
            obj.td.record();
        end

        function idle(obj)
            obj.td.idle();
        end
    end
end
