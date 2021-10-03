package com.sulake.core.localization
{
   public class LocalizationDefinition implements ILocalizationDefinition
   {
       
      
      private var _name:String;
      
      private var var_1415:String;
      
      private var var_816:String;
      
      private var var_1417:String;
      
      private var var_1416:String;
      
      public function LocalizationDefinition(param1:String, param2:String, param3:String)
      {
         super();
         var _loc4_:Array = param1.split("_");
         var_1416 = _loc4_[0];
         var _loc5_:Array = String(_loc4_[1]).split(".");
         var_1415 = _loc5_[0];
         var_1417 = _loc5_[1];
         _name = param2;
         var_816 = param3;
      }
      
      public function get countryCode() : String
      {
         return var_1415;
      }
      
      public function get languageCode() : String
      {
         return var_1416;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function get encoding() : String
      {
         return var_1417;
      }
      
      public function get id() : String
      {
         return var_1416 + "_" + var_1415 + "." + var_1417;
      }
   }
}
