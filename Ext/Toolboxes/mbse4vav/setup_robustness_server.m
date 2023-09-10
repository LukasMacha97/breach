function server = setup_robustness_server()

    port = 5000; 

    server = tcpserver('localhost', port,'Timeout',15e10,'ConnectionChangedFcn',@connectionFcn);

end