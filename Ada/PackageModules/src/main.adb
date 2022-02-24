with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
procedure Main is
   task type PrintTask (I : Integer);

   task body PrintTask is
      K : Integer := I;
      StartTime, EndTime : Time;
      MilliS : Duration;
   begin
      StartTime := Clock;
      for I in 1..1000000000 loop
         K := K * (-1);
      end loop;
      EndTime := Clock;
      MilliS := (EndTime - StartTime) * 1000;
      Put_Line("A Single Tasks Runtime = " & Duration'Image(MilliS));
   end PrintTask;
   type Ptr_PrintTask is access PrintTask;
   T : Ptr_PrintTask;

   N : Integer := 0;
   StartTime, EndTime : Time;
   MilliS : Duration;
   Iterations : Integer := 4;
   A : Float := 0.0;
begin
   StartTime := Clock;
   for I in 1..Iterations loop
      N := 1;
      for I in 1..1000000000 loop
         N := N * (-1);
      end loop;
   end loop;
   EndTime := Clock;
   MilliS := (EndTime - StartTime) * 1000;
   put_line("Untasked Runtime = " & Duration'Image(MilliS) & " milliseconds.");
   A := Float(MilliS);
   StartTime := Clock;
   for I in 1..Iterations loop
      T := new PrintTask(I);
   end loop;
   EndTime := Clock;
   MilliS := (EndTime - StartTime) * 1000;

end Main;
