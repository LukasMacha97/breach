function connectionFcn(src,~)

if src.Connected

   disp("Client has connected.")
   
   data = read(src, src.NumBytesAvailable, "string");

   disp(data);
   
   robustness = get_system_robustness(data);
   
   write(src,string(robustness))

else
   
    disp("Client has disconnected.")

end
end