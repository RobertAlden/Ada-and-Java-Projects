with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   limit : Integer := 2_000_000;
   type primesList is array(1..limit) of Boolean;
   primes : primesList := (False, others => True);

   Sum : Long_Long_Long_Integer := 0;
begin
   For I in 2..Integer(Sqrt(Float(limit))) loop
      If primes(I) then
         declare
            J : Integer := I**2;
         begin
            while J <= limit loop
               primes(J) := False;
               J := J + i;
            end loop;
         end;
      end if;
   end loop;

   For I in primes'Range loop
      if primes(I) then
         Sum := Sum + Long_Long_Long_Integer(I);
      end if;
   end loop;
   Put_Line(Long_Long_Long_Integer'Image(Sum));
   --Put_Line(Long_Long_Long_Integer'Image(Long_Long_Long_Integer'Last));
end Main;
