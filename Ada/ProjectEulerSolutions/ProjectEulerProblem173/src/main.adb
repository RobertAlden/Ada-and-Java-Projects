with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
procedure Main is
   Limit : Long_Long_Long_Integer := 1_000_000;
   count : Integer := 0;
   N : Long_Long_Long_Integer := 3;
begin
   while N <= (Limit/4) + 1 loop
      declare
         K : Long_Long_Long_Integer;
      begin
         K := N-2;
         while (K >= (2 - (N mod 2))) loop
            if (N**2)-(K**2) <= Limit then
               count := count + 1;
            else
               exit;
            end if;
            K := K - 2;
         end loop;
      end;
      N := N + 1;
   end loop;
   Put_Line(Integer'Image(count));
end Main;
