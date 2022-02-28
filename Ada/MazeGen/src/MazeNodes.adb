with Ada.Text_IO;
package body MazeNodes is
   procedure Connect (This : in out MazeNode;
                      Target : in out ptr_MazeNode;
                      D : Direction) is
   begin
      This.Connection := Target;
      case D is
      when North =>
         This.NorthWall := False;
         Target.all.SouthWall := False;
      when East =>
         This.EastWall  := False;
         Target.all.WestWall := False;
      when South =>
         This.SouthWall := False;
         Target.all.NorthWall := False;
      when West =>
         This.WestWall  := False;
         Target.all.EastWall := False;
      when None =>
         null;
      end case;
   end Connect;
end MazeNodes;
