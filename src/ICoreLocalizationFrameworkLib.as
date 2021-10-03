package
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.localization.ILocalizationDefinition;
   import com.sulake.core.localization.enum.LocalizationEvent;
   import com.sulake.iid.IIDCoreLocalizationManager;
   
   public class ICoreLocalizationFrameworkLib
   {
      
      public static var LocalizationEvent:Class = LocalizationEvent;
      
      public static var ILocalization:Class = ILocalization;
      
      public static var ICoreLocalizationManager:Class = ICoreLocalizationManager;
      
      public static var ILocalizable:Class = ILocalizable;
      
      public static var IIDCoreLocalizationManager:Class = IIDCoreLocalizationManager;
      
      public static var ILocalizationDefinition:Class = ILocalizationDefinition;
       
      
      public function ICoreLocalizationFrameworkLib()
      {
         super();
      }
   }
}
