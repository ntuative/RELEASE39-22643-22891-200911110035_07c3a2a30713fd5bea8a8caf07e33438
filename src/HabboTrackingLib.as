package
{
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.iid.IIDHabboTracking;
   import mx.core.SimpleApplication;
   
   public class HabboTrackingLib extends SimpleApplication
   {
      
      public static var IIDHabboTracking:Class = IIDHabboTracking;
      
      public static var HabboTracking:Class = HabboTracking;
      
      public static var manifest:Class = HabboTrackingLib_manifest;
       
      
      public function HabboTrackingLib()
      {
         super();
      }
   }
}
