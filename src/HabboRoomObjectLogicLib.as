package
{
   import com.sulake.habbo.room.RoomObjectFactory;
   import com.sulake.iid.IIDRoomObjectFactory;
   import mx.core.SimpleApplication;
   
   public class HabboRoomObjectLogicLib extends SimpleApplication
   {
      
      public static var RoomObjectFactory:Class = RoomObjectFactory;
      
      public static var IIDRoomObjectFactory:Class = IIDRoomObjectFactory;
      
      public static var manifest:Class = HabboRoomObjectLogicLib_manifest;
       
      
      public function HabboRoomObjectLogicLib()
      {
         super();
      }
   }
}
