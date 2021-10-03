package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class CutToHeight implements BinarySearchTest
   {
       
      
      private var var_174:String;
      
      private var var_380:int;
      
      private var var_197:ITextWindow;
      
      public function CutToHeight()
      {
         super();
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         var_174 = param1;
         var_197 = param2;
         var_380 = param3;
      }
      
      public function test(param1:int) : Boolean
      {
         var_197.text = var_174.substring(0,param1) + "...";
         return var_197.textHeight > var_380;
      }
   }
}
