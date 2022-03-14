with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Containers.Vectors;
procedure Main is
   package Int_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Int_Vectors;

   function IsPrime(N:Integer) return Boolean is
   begin
      For I in 2..Integer(Sqrt(Float(N))) loop
         if N mod I = 0 then
            return False;
         end if;
      end loop;
      return True;
   end IsPrime;

   function ConCatInt(N1:Integer; N2:Integer) return Integer is
      output : Integer;
   begin
      output := Integer'Value(Integer'Image(N1)(2..Integer'Image(N1)'Last) &
                                Integer'Image(N2)(2..Integer'Image(N2)'Last)
                             );
      return output;
   end ConCatInt;

   function PermuteVector(V : Vector) return Vector is
      temp : Vector := Copy(V);
      output : Vector;
   begin
      For I in temp.First_Index .. temp.Last_Index loop
         declare
            C : Integer := temp.First_Element;
         begin
            temp.Delete_First;
            For K of temp loop
               output.append(ConCatInt(C,K));
               output.append(ConCatInt(K,C));
            end loop;
         end;
      end loop;

      return output;
   end PermuteVector;

   function IsVectorPrime(V : Vector) return Boolean is
   begin
      For K of V loop
         If not IsPrime(K) then
            return False;
         end if;
      end loop;
      return True;
   end IsVectorPrime;

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

   TestVector : Vector := 3 & 7 & 109 & 673;
   Primes : Vector;
   Limit : Integer := 10000;
   PV : Vector;
   A : Integer;
   B : Integer;
   C : Integer;
   D : Integer;
   E : Integer;
begin
   Primes := SieveOfEratothenes(Limit);
   --for K of TestVector loop
   --   Put(Integer'Image(K));
   --end loop;
   A := 2;
   Outer : While A < Integer(Primes.Length) loop
      B := A + 1;
      While B < Integer(Primes.Length) loop
         TestVector := Primes(A) & Primes(B);
         PV := PermuteVector(TestVector);
         if IsVectorPrime(PV) then
            C := B + 1;
            While C < Integer(Primes.Length) loop
               TestVector := Primes(A) & Primes(B) & Primes(C);
               PV := PermuteVector(TestVector);
               if IsVectorPrime(PV) then
                  D := C + 1;
                  While D < Integer(Primes.Length) loop
                     TestVector := Primes(A) & Primes(B) & Primes(C) & Primes(D);
                     PV := PermuteVector(TestVector);
                     if IsVectorPrime(PV) then
                        E := D + 1;
                        While E < Integer(Primes.Length) loop
                           TestVector := Primes(A) & Primes(B) & Primes(C) & Primes(D) & Primes(E);
                           declare
                              sumV : Integer := 0;
                           begin
                              PV := PermuteVector(TestVector);
                              if IsVectorPrime(PV) then
                                 For I of TestVector loop
                                    sumV := sumV + I;
                                    Put(Integer'Image(I));

                                 end loop;
                                 Put(Integer'Image(sumV));
                                 Put_Line("");
                                 exit Outer;
                              end if;
                           end;
                           E := E + 1;
                        end loop;
                     end if;
                     D :=  D + 1;
                  end loop;
               end if;
               C := C + 1;
            end loop;
         end if;
         B := B + 1;
      end loop;
      --Put_Line(Integer'Image(A));
      A := A + 1;
   end loop Outer;
end Main;
