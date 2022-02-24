with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   function Fibonacci(N : Integer) return Integer is

   begin
      if N < 2 then
         return N;
      else
         return Fibonacci(N-1) + Fibonacci(N-2);
      end if;
   end Fibonacci;
begin
   --  Insert code here.
   Put_Line(Integer'Image(Fibonac;
   -- Put_Line(Long_Long_Integer'Image(Long_Long_Integer'Last));
end Main;
