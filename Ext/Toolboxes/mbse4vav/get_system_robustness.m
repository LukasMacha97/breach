function robustness = get_system_robustness(simulation_data_file)
       
        % read Model.Connect simulation results from csv file (address received in simulation_data_file from Python TCP Client) 

        simulation_data_file = deblank(simulation_data_file); 
                  
        InitBreach;
                
        simulation_data_table = readtable(simulation_data_file); 
        
        time = simulation_data_table{:,1}';

        signal_gen = from_table_signal_gen(simulation_data_table);

        B = BreachSignalGen({signal_gen});
                
        B.Sim(time);

        
        % read file with system requirements in signal temporal logic for now this assumes that the file only contains single requirement 

        requirements_file = "X:\MechEng\ResearchProjects\CJBrace\EG-ME1375\MBSE4V&V\00\data\requirements\requirements.stl";

        requirements = STL_ReadFile(requirements_file);

        for i=1:length(requirements)
          
            req = BreachRequirement(requirements{i});

            robustness = req.Eval(B);

        end   
                  
end
