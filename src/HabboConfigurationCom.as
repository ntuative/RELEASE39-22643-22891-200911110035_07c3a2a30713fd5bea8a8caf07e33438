package
{
   import com.sulake.habbo.configuration.HabboConfigurationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import mx.core.SimpleApplication;
   
   public class HabboConfigurationCom extends SimpleApplication
   {
      
      public static var default_configuration:Class = HabboConfigurationCom_default_configuration;
      
      public static var IIDHabboConfigurationManager:Class = IIDHabboConfigurationManager;
      
      public static var HabboConfigurationManager:Class = HabboConfigurationManager;
      
      public static var manifest:Class = HabboConfigurationCom_manifest;
       
      
      public function HabboConfigurationCom()
      {
         super();
      }
   }
}
