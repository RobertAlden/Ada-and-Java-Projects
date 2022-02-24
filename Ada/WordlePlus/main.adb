with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Discrete_Random;

procedure Main is
   F         : File_Type;
   File_Name : constant String := "words.txt";
   Valid_Words_File_Name : constant String := "valid_words.txt";
   Word : String(1 .. 5);
   Word_Count : Integer := 0;
   Selected_Word_Index : Integer;
   SU : Unbounded_String;
   Padding : String := "     ";


   subtype Random_Range is Integer range 1 .. 100000;
   package R is new
     Ada.Numerics.Discrete_Random (Random_Range);
   use R;

   G : Generator;

   Guessed_Word : String(1 .. 5);
   Word_Copy : String(1..5);
   Result : String(1..5);
   Attempts : Integer := 6;
   State : Integer := 0;
   Flag : Integer := 0;
begin
   reset(G);
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Word := Get_Line (F);
      Word_Count := Word_Count + 1;
   end loop;
   -- Put_Line(Integer'Image(Word_Count));
   Selected_Word_Index := Random(G) mod Word_Count;

   Close (F);

   Open (F, In_File, File_Name);
   for I in 1 .. Selected_Word_Index loop
      Word := Get_Line(F);
   end loop;
   Close(F);

   -- Put_Line(Word & " @ Line " & Integer'Image(Selected_Word_Index));
   Word_Copy := Word;
   Put_Line("Guess the secret five letter word!");
   Put_Line("An ! means you've guessed the right letter in the right place, ");
   Put_Line("An ? means that letter occurs in the word, but its not in the right spot, ");
   Put_Line("A - means that letter does not occur in the word to be guessed.");
   Put_Line("You have 6 tries, lowercase only, only valid words are accepted, good luck!");
   for I in 1 .. Attempts loop
      Result := "-----";
      Word := Word_Copy;
      loop
         SU := To_Unbounded_String(Get_Line);
         while Length(SU) < 5 loop
            SU := SU & ' ';
         end loop;

         Guessed_Word := To_String(SU)(1..5);
         Flag := 0;
         Open (F, In_File, Valid_Words_File_Name);
         while not End_Of_File (F) loop
            if Guessed_Word = Get_Line(F) then
               Flag := 1;
               exit;
            end if;
         end loop;
         Close (F);
         exit when Flag = 1;
         Put_Line(Guessed_Word & " is not a valid word, guess again.");
      end loop;

      if Guessed_Word = Word then
         Put_Line("You Got It in" & Integer'Image(I) & " Attempts!" );
         Flag := 10;
         exit;
      end if;

      for C in 1..5 loop
         for W in 1..5 loop
            if (C = W and Word(W) = Guessed_Word(C)) then
               Result(C) := '!';
               Word(C) := '-';
            end if;
         end loop;
      end loop;
      for C in 1..5 loop
         for W in 1..5 loop
            if (Word(W) = Guessed_Word(C) and Result(C) = '-') then
               Result(C) := '?';
               Word(W) := '-';
            end if;
         end loop;
      end loop;
      Put_Line(Result);
   end loop;
   if Flag /= 10 then
      Put_Line("The word was " & Word_Copy & ".");
      Put_Line("Better luck next time.");
   end if;
end Main;
