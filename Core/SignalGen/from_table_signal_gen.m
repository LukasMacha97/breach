classdef from_table_signal_gen < signal_gen
% from_workspace_signal_gen meant to be used with a From Workspace block.
% TODO: read the signals so they create a 'time' and 'value' n x 2 double for each fieldname in the struct org_signals (e.g. read the )
    properties
        data_fmt = 'timed_variables' 
        org_signals 
    end
    methods
        function this = from_table_signal_gen(data_table)
            
            this.signals = data_table.Properties.VariableNames(2:end); % assumes first column is time           
            this.params = {};
            for isig = 1:numel(this.signals)
                this.org_signals.(this.signals{isig}) = [data_table{:,1}, data_table.(this.signals{isig})];
            end
        end
        
        
        function [X, time]= computeSignals(this, p, time)

            X = zeros(numel(this.signals), numel(time));
            for isig = 1:numel(this.signals)
                % assumes that signals are in variable with [time  values]
                sig = this.org_signals.(this.signals{isig});
                t_sig = sig(:,1);
                v_sig = sig(:,2);
                x = interp1(t_sig, v_sig, time', 'linear', 'extrap'); 
                X(isig, :) = x';
            end
            
        end
    end
end