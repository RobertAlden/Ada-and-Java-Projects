with Ada.Strings; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;
procedure Main is
   S : String := "aaaaabbbbbccccc";
   X : Integer := 2;
begin

   Put_Line(S);
   X := (X - 1) * 5 + 1;

   Sol := Word(X..X+4);
end Main;
