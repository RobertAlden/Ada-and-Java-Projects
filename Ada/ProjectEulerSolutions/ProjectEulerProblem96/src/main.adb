with Ada.Text_IO; use Ada.Text_IO;
--with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Main is
   subtype SudokuValue is Integer range 0..9;
   type SudokuGrid is array(1..9, 1..9) of Character;

   F         : File_Type;
   File_Name : constant String := "C:\Users\randy\Documents\GitHub\Ada-and-Java-Projects\Ada\ProjectEulerSolutions\ProjectEulerProblem96\src\p096_sudoku.txt";
   Answer : Integer := 0;

   function TestRow(S : SudokuGrid; N : Character; Row : Integer) return Boolean is
   begin
      for I in 1..9 loop
         if N = S(I,Row) then
            return False;
         end if;
      end loop;
      return True;
   end TestRow;
   function TestCol(S : SudokuGrid; N : Character; Col : Integer) return Boolean is
   begin
      for I in 1..9 loop
         if N = S(Col,I) then
            return False;
         end if;
      end loop;
      return True;
   end TestCol;
   function TestBox(S : SudokuGrid; N : Character;
                    BoxX : Integer; BoxY : Integer) return Boolean is
      r : Integer;
      c : Integer;
   begin
      r := ((BoxX-1) - ((BoxX-1) mod 3))+1;
      c := ((BoxY-1) - ((BoxY-1) mod 3))+1;
      for y in c..c+2 loop
         for x in r..r+2 loop
            if N = S(x,y) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end TestBox;

   function TestCell(S : SudokuGrid; N : Character;
                     X : Integer; Y : Integer) return Boolean is
   begin
      return (TestRow(S,N,Y) and then TestCol(S,N,X) and then TestBox(S,N,X,Y));
   end TestCell;

   function ValidateSudoku(S : in out SudokuGrid) return Boolean is
      Test : Character;
   begin
      For y in S'Range(1) loop
         For x in S'Range(2) loop
            Test := S(x,y);
            S(x,y) := '0';
            if not TestRow(S,Test,y) then
               return False;
            end if;
            S(x,y) := Test;


            Test := S(x,y);
            S(x,y) := '0';
            if TestCol(S,Test,x) then
               return False;
            end if;
            S(x,y) := Test;
         end loop;
      end loop;
      For y in 1..3 loop
         For x in 1..3 loop
            Test := S(x,y);
            S(x,y) := '0';
            if TestBox(S,Test,x,y) then
               return False;
            end if;
            S(x,y) := Test;
         end loop;
      end loop;
      return True;
   end ValidateSudoku;

   function Solve(S : in out SudokuGrid) return Boolean is
   begin
      For y in S'Range(1) loop
         For x in S'Range(2) loop
            if S(x,y) = '0' then
               for I in 1..9 loop
                  if TestCell(S,Integer'Image(I)(2),X,Y) then
                     S(x,y) := Integer'Image(I)(2);
                     if Solve(S) then
                        return True;
                     else
                        S(x,y) := '0';
                     end if;
                  end if;
               end loop;
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end;
   --Input : String(1..1);
begin
   --Input := Get_Line;
   Open (F, In_File, File_Name);
   while not End_Of_File(F) loop
      declare
         Su : SudokuGrid;
         Res : Boolean;
      begin
         Skip_Line(F);
         For y in Su'Range(1) loop
            For x in Su'Range(2) loop
               if not End_Of_File(F) then
                  Get(File => F, Item => Su(x,y));
               end if;
            end loop;
         end loop;
         if not End_Of_File(F) then
            Skip_Line(F);
         end if;

         Put_Line("Inital:");
         For y in Su'Range(1) loop
            For x in Su'Range(2) loop
               Put(Su(x,y));
            end loop;
            Put_Line("");
         end loop;
         Put_Line("Solved:");
         Res := Solve(Su);
         For y in Su'Range(1) loop
            For x in Su'Range(2) loop
               Put(Su(x,y));
            end loop;
            Put_Line("");
         end loop;
         Answer := Answer + Integer'Value(Su(1,1) & Su(2,1) & Su(3,1));
      end;
   end loop;
   Close(F);
   Put_Line(Integer'Image(Answer));

end Main;
