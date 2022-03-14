with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Containers.Vectors;
with Ada.Real_Time; use Ada.Real_Time;
procedure Main is
   package Int_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Int_Vectors;

   function SieveOfEratothenes(Limit : Integer) return Vector is
      type BoolArr is array(2..Limit) of Boolean;
      PrimeBools : BoolArr := (others => True);
      primes : Vector;
   begin
      for I in PrimeBools'First..PrimeBools'Last loop
         if PrimeBools(I) then
            declare
               K : Integer := I+I;
            begin
               while K <= PrimeBools'Last loop
                  PrimeBools(K) := False;
                  K := K + I;
               end loop;
            end;
            primes.Append(I);
         end if;
      end loop;
      return primes;
   end SieveOfEratothenes;

   procedure ExtendSieve(V : in out Vector) is
      NewLimit : Integer := V.Last_Element;
      type BoolArr is array(NewLimit+1..NewLimit*2) of Boolean;
      PrimeBools : BoolArr := (others => True);
   begin
      For I of V loop
         if I ** 2 <= PrimeBools'Last then
            declare
               K : Integer := PrimeBools'First;
            begin
               While K mod I /= 0 loop
                  K := K + 1;
               end loop;
               while K <= PrimeBools'Last loop
                  PrimeBools(K) := False;
                  K := K + I;
               end loop;
            end;
         else
            exit;
         end if;
      end loop;

      For I in PrimeBools'Range loop
         if PrimeBools(I) then
            V.Append(I);
         end if;
      end loop;
   end ExtendSieve;

   Start_Time, Stop_Time : Time;
   Elapsed_Time          : Time_Span;

   MyPrimes : Vector;
   TargetLength : Integer := 10000;
begin
   --  Insert code here.
   Start_Time := Clock;
   --MyPrimes := SieveOfEratothenes(2000000);
   Stop_Time    := Clock;
   Elapsed_Time := Stop_Time - Start_Time;
   Put_Line ("Elapsed time: "
             & Duration'Image (To_Duration (Elapsed_Time))
             & " seconds");
   Put_Line(Integer'Image(Integer(MyPrimes.Length)));

   Start_Time := Clock;
   MyPrimes := SieveOfEratothenes(100);
   While Integer(MyPrimes.Length) < TargetLength loop
      ExtendSieve(MyPrimes);
   end loop;
   --MyPrimes := SieveOfEratothenes(1000);

   Stop_Time    := Clock;
   Elapsed_Time := Stop_Time - Start_Time;
   Put_Line ("Elapsed time: "
             & Duration'Image (To_Duration (Elapsed_Time))
             & " seconds");
   Put_Line(Integer'Image(Integer(MyPrimes.Length)));
   For P of MyPrimes loop
      Put(Integer'Image(P));
   end loop;


end Main;
