package
{
   import com.sulake.habbo.room.RoomEngine;
   import com.sulake.iid.IIDRoomEngine;
   import mx.core.SimpleApplication;
   
   public class HabboRoomEngineCom extends SimpleApplication
   {
      
      public static var IIDRoomEngine:Class = IIDRoomEngine;
      
      public static var RoomEngine:Class = RoomEngine;
      
      public static var manifest:Class = HabboRoomEngineCom_manifest;
       
      
      public function HabboRoomEngineCom()
      {
         super();
      }
   }
}
