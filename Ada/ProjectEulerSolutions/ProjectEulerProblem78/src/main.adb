with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
procedure Main is
   function DistinctSums(N : Integer) return Integer is
      sum : Integer := 0;
   begin
      if N = 2 then
         return 1;
      end if;
      For I in 1..N-1 loop
         Sum := Sum + 1 + DistinctSums(N-I);
      end loop;
      Put_Line(Integer'Image(Sum));
      return Sum;

   end DistinctSums;

   package Value_Functions is new Ada.Numerics.Generic_Elementary_Functions (
     Float);

  use Value_Functions;

   Test : Float := 64.0;
begin
   Put_Line(Integer'Image(DistinctSums(5)));
   Put_Line(Integer'Image(Integer((Test**(1.0/4.0)))));
end Main;
