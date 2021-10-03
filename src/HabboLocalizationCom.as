package
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.habbo.localization.HabboLocalizationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import mx.core.SimpleApplication;
   
   public class HabboLocalizationCom extends SimpleApplication
   {
      
      public static var HabboLocalizationManager:Class = HabboLocalizationManager;
      
      public static var IHabboLocalizationManager:Class = IHabboLocalizationManager;
      
      public static var ICoreLocalizationManager:Class = ICoreLocalizationManager;
      
      public static var manifest:Class = HabboLocalizationCom_manifest;
      
      public static var IIDCoreLocalizationManager:Class = IIDCoreLocalizationManager;
      
      public static var default_localization:Class = HabboLocalizationCom_default_localization;
      
      public static var keys_in_use:Class = HabboLocalizationCom_keys_in_use;
      
      public static var IIDHabboLocalizationManager:Class = IIDHabboLocalizationManager;
       
      
      public function HabboLocalizationCom()
      {
         super();
      }
   }
}
