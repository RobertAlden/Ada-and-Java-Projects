with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Streams;
with GNAT.Sockets; use GNAT.Sockets;
procedure Main is
   task Ping is
      entry Start;
      entry Stop;
   end Ping;
   task body Ping is
      Address  : Sock_Addr_Type;
      Socket   : Socket_Type;
      Channel  : Stream_Access;
   begin
      accept Start;
      --  See comments in Ping section for the first steps.
      Address.Addr := Addresses (Get_Host_By_Name ("localhost"), 1);
      Address.Port := 10203;
      Create_Socket (Socket);
      Set_Socket_Option
        (Socket,
         Socket_Level,
         (Reuse_Address, True));
      --  Force Pong to block
      delay 0.2;
      --  If the client's socket is not bound, Connect_Socket will
      --  bind to an unused address. The client uses Connect_Socket to
      --  create a logical connection between the client's socket and
      --  a server's socket returned by Accept_Socket.
      Connect_Socket (Socket, Address);
      Channel := Stream (Socket);
      --  Send message to server Pong.
      String'Output (Channel, "Apples + Oranges = {42}");
      --  Force Ping to block
      delay 0.2;
      --  Receive and print message from server Pong.
      --Ada.Text_IO.Put_Line (String'Input (Channel));
      Close_Socket (Socket);

      accept Stop;
   exception when E : others =>
      Ada.Text_IO.Put_Line
        (Exception_Name (E) & ": " & Exception_Message (E));
   end Ping;
begin
   --  Indicate whether the thread library provides process
   --  blocking IO. Basically, if you are not using FSU threads
   --  the default is ok.
   Initialize (Process_Blocking_IO => False);
   Ping.Start;
   --Pong.Start;
   delay 1.0;
   Ping.Stop;
   --Pong.Stop;
   Finalize;
   --     loop
   --        Open (F, Out_File, File_Name);
   --        Reset(F);
   --        Put_Line(F, Integer'Image(I));
   --        Close(F);
   --        I := I + 1;
   --        delay 0.025;
   --     end loop;
end Main;
