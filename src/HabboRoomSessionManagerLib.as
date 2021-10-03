package
{
   import com.sulake.habbo.session.RoomSessionManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import mx.core.SimpleApplication;
   
   public class HabboRoomSessionManagerLib extends SimpleApplication
   {
      
      public static var RoomSessionManager:Class = RoomSessionManager;
      
      public static var IIDHabboRoomSessionManager:Class = IIDHabboRoomSessionManager;
      
      public static var manifest:Class = HabboRoomSessionManagerLib_manifest;
       
      
      public function HabboRoomSessionManagerLib()
      {
         super();
      }
   }
}
