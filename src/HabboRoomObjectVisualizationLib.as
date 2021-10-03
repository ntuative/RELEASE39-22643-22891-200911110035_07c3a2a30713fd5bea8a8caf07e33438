package
{
   import com.sulake.habbo.room.object.RoomObjectVisualizationFactory;
   import com.sulake.iid.IIDRoomObjectVisualizationFactory;
   import mx.core.SimpleApplication;
   
   public class HabboRoomObjectVisualizationLib extends SimpleApplication
   {
      
      public static var RoomObjectVisualizationFactory:Class = RoomObjectVisualizationFactory;
      
      public static var IIDRoomObjectVisualizationFactory:Class = IIDRoomObjectVisualizationFactory;
      
      public static var manifest:Class = HabboRoomObjectVisualizationLib_manifest;
       
      
      public function HabboRoomObjectVisualizationLib()
      {
         super();
      }
   }
}
