package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   
   public class ToolbarIconAnimator
   {
       
      
      private var _state:String;
      
      private var var_990:Boolean;
      
      private var var_1037:String;
      
      private var var_672:Array;
      
      private var var_56:int;
      
      private var var_829:Array;
      
      private var var_2057:Number;
      
      private var var_2056:Number;
      
      private var var_557:int;
      
      public function ToolbarIconAnimator(param1:Object, param2:IAssetLibrary, param3:IBitmapWrapperWindow, param4:Number, param5:Number)
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         super();
         if(param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         var_2057 = param4;
         var_2056 = param5;
         var_56 = 0;
         var_557 = 0;
         var_672 = new Array();
         var_829 = new Array();
         _state = param1.id;
         var_1037 = param1.nextState;
         var_990 = param1.loop;
         var _loc8_:XMLList = param1.frames;
         if(_loc8_.length() > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc8_.length())
            {
               _loc10_ = _loc8_[_loc9_];
               _loc6_ = "icon_" + param1.nameBase + "_" + _loc10_.@id;
               _loc10_.@assetName = _loc6_;
               _loc7_ = getBitmapDataFromAsset(_loc6_,param2);
               if(_loc7_ != null)
               {
                  var_672.push(_loc10_);
                  var_829.push(_loc7_);
               }
               _loc9_++;
            }
         }
         else
         {
            _loc6_ = "icon_" + param1.nameBase + "_0";
            _loc7_ = getBitmapDataFromAsset(_loc6_,param2);
            if(_loc7_ != null)
            {
               var_672.push(new XML());
               var_829.push(_loc7_);
            }
         }
         updateAssetInWindow(param3);
      }
      
      public function get frameCount() : int
      {
         return var_672.length;
      }
      
      public function update(param1:IBitmapWrapperWindow) : void
      {
         if(var_990 == true || var_557 == 0)
         {
            if(false)
            {
               ++var_56;
               if(var_56 >= var_672.length)
               {
                  var_56 = 0;
                  ++var_557;
               }
            }
            if(var_990 == true || var_557 == 0)
            {
               updateAssetInWindow(param1);
            }
         }
      }
      
      public function hasNextState() : Boolean
      {
         return var_990 == false && var_557 == 1 && var_1037 != _state;
      }
      
      private function updateAssetInWindow(param1:IBitmapWrapperWindow) : void
      {
         var _loc2_:* = null;
         if(var_56 <= var_829.length)
         {
            _loc2_ = var_829[var_56];
            if(_loc2_ != null && param1 != null && _loc2_ is BitmapData)
            {
               param1.width = _loc2_.width;
               param1.height = _loc2_.height;
               param1.bitmap = _loc2_.clone();
            }
         }
      }
      
      public function get nextState() : String
      {
         return var_1037;
      }
      
      private function getBitmapDataFromAsset(param1:String, param2:IAssetLibrary) : BitmapData
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2.hasAsset(param1))
         {
            _loc3_ = param2.getAssetByName(param1) as BitmapDataAsset;
            if(_loc3_ != null)
            {
               return (_loc3_.content as BitmapData).clone();
            }
         }
         return null;
      }
   }
}
