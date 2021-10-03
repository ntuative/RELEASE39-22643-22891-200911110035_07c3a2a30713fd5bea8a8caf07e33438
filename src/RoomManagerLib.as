package
{
   import com.sulake.iid.IIDRoomManager;
   import com.sulake.room.RoomManager;
   import mx.core.SimpleApplication;
   
   public class RoomManagerLib extends SimpleApplication
   {
      
      public static var IIDRoomEngine:Class = IIDRoomManager;
      
      public static var RoomManager:Class = RoomManager;
      
      public static var manifest:Class = RoomManagerLib_manifest;
       
      
      public function RoomManagerLib()
      {
         super();
      }
   }
}
