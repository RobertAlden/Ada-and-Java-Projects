with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
procedure Main is
   function Lamina(Limit : Integer) return Integer is

      count : Integer := 0;
      N : Long_Long_Long_Integer := Long_Long_Long_Integer(Sqrt(Float(Limit)));
   begin
      while N <= Long_Long_Long_Integer((Limit/4) + 1) loop
         declare
            K : Long_Long_Long_Integer;
         begin
            K := N-2;
            while (K >= (2 - (N mod 2))) loop
               if (N**2)-(K**2) = Long_Long_Long_Integer(Limit) then
                  count := count + 1;
               end if;
               K := K - 2;
            end loop;
            end;
         N := N + 1;
      end loop;
      return count;
   end Lamina;

   type Int_Arr is array(8..1_000_000) of Integer;
   N_arr : Int_Arr := (others => 0);

   type Result_Arr is array(1..10) of Integer;
   Res_Arr : Result_Arr := (others => 0);
begin
   Put_Line(Integer'Image(Lamina(8)));
   Put_Line(Integer'Image(Lamina(32)));
   Put_Line(Integer'Image(Lamina(1000000)));
   For I in N_arr'Range loop
      N_arr(I) := Lamina(I);
   end loop;
   For I in Res_Arr'Range loop
      declare
         count : Integer := 0;
      begin
         null;
      end;
   end loop;
end Main;
