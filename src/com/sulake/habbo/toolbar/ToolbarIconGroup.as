package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public class ToolbarIconGroup
   {
       
      
      private var var_272:Array;
      
      private var var_753:Number;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_427:String;
      
      private var _containerWindow:IWindowContainer;
      
      private var var_1557:int = 5;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_575:Array;
      
      private var name_1:IEventDispatcher;
      
      private var var_1558:Number;
      
      private var var_379:ToolbarBarMenuAnimator;
      
      private var var_1020:Array;
      
      private var var_1560:XML;
      
      private var var_1559:int;
      
      private var var_1019:Number;
      
      private var var_1021:Array;
      
      public function ToolbarIconGroup(param1:IHabboWindowManager, param2:IAssetLibrary, param3:int, param4:IEventDispatcher, param5:IWindowContainer, param6:ToolbarBarMenuAnimator)
      {
         var_272 = new Array();
         var_575 = new Array();
         var_1020 = new Array();
         var_1021 = new Array();
         super();
         _windowManager = param1;
         _assetLibrary = param2;
         _containerWindow = param5;
         name_1 = param4;
         var_379 = param6;
      }
      
      public function get size() : Number
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_272.length)
         {
            if(var_272[_loc2_].exists)
            {
               _loc1_ += var_1019;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function setIcon(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         _loc3_ = getIconById(param1);
         if(_loc3_ != null)
         {
            _loc3_.setIcon(param2);
            alignItems();
         }
      }
      
      public function acceptsIcon(param1:String) : Boolean
      {
         return var_1021.indexOf(param1) > -1;
      }
      
      public function get iconCount() : int
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_272.length)
         {
            if(var_272[_loc2_].exists)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set windowBottomMargin(param1:int) : void
      {
         var_1559 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         while(false)
         {
            var_575.shift();
            _loc1_ = var_272.shift();
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      public function set orientation(param1:String) : void
      {
         var_427 = param1;
      }
      
      public function getIconByMenuId(param1:String) : ToolbarIcon
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < var_272.length)
         {
            _loc2_ = var_272[_loc3_];
            if(_loc2_ != null)
            {
               if(_loc2_.docksMenu(param1))
               {
                  return _loc2_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function set iconSize(param1:Number) : void
      {
         var_1019 = param1;
      }
      
      public function setContent(param1:String, param2:BitmapData) : void
      {
         var _loc3_:* = null;
         _loc3_ = getIconById(param1);
         if(_loc3_ != null)
         {
            _loc3_.setIconBitmapData(param2);
            alignItems();
         }
      }
      
      public function containsIcon(param1:String) : Boolean
      {
         return var_575.indexOf(param1) > -1;
      }
      
      private function alignItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(_loc4_ < var_1020.length)
         {
            _loc2_ = var_575.indexOf(var_1020[_loc4_]);
            if(_loc2_ > -1)
            {
               _loc1_ = var_272[_loc2_];
               if(_loc1_.exists)
               {
                  _loc1_.changePosition(var_427 == "LEFT" || var_427 == "RIGHT",var_753 + _loc3_,var_1019);
                  _loc3_ += var_1019;
               }
            }
            _loc4_++;
         }
      }
      
      public function get windowMargin() : int
      {
         return var_1557;
      }
      
      public function get windowBottomMargin() : int
      {
         return var_1559;
      }
      
      private function createIconObject(param1:String) : ToolbarIcon
      {
         var _loc2_:* = null;
         _loc2_ = getIconById(param1);
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = new ToolbarIcon(this,_windowManager,_assetLibrary,param1,name_1,var_379);
         _containerWindow.addChild(_loc2_.window);
         var_575.push(param1);
         var_272.push(_loc2_);
         return _loc2_;
      }
      
      public function addContentIndexFromXmlList(param1:XML) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var_1560 = param1;
         _loc4_ = param1.elements("icon");
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.length())
         {
            _loc8_ = _loc4_[_loc7_];
            _loc2_ = "null";
            if(_loc2_ != null)
            {
               if(!containsIcon(_loc2_))
               {
                  _loc6_ = createIconObject(_loc2_);
                  if(_loc6_ == null)
                  {
                     return false;
                  }
                  _loc6_.defineFromXML(_loc8_);
                  var_1020.push(_loc2_);
                  _loc5_ = _loc8_.elements("dock");
                  if(_loc5_.length() > 0)
                  {
                     _loc9_ = 0;
                     while(_loc9_ < _loc5_.length())
                     {
                        _loc3_ = "null";
                        var_1021.push(_loc3_);
                        _loc6_.dockMenu(_loc3_,getMenuYieldList(_loc3_),_loc5_[_loc9_].@locktoicon == "AnimationAction");
                        _loc9_++;
                     }
                  }
                  else
                  {
                     var_1021.push(_loc2_);
                     if(_loc8_.elements("nodock").length() == 0)
                     {
                        _loc6_.dockMenu(_loc2_);
                     }
                  }
               }
            }
            _loc7_++;
         }
         return true;
      }
      
      public function set position(param1:Number) : void
      {
         var_753 = param1;
         alignItems();
      }
      
      public function removeContent(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = var_575.indexOf(param1);
         if(_loc2_ > -1)
         {
            _loc3_ = getIconById(param1);
            if(_loc3_ != null)
            {
               _loc3_.setIcon(false);
            }
         }
      }
      
      public function getIconById(param1:String) : ToolbarIcon
      {
         if(!containsIcon(param1))
         {
            return null;
         }
         return var_272[var_575.indexOf(param1)];
      }
      
      public function set defaultIconSize(param1:Number) : void
      {
         var_1558 = param1;
      }
      
      public function get defaultIconSize() : Number
      {
         return var_1558;
      }
      
      public function set windowMargin(param1:int) : void
      {
         var_1557 = param1;
      }
      
      public function getMenuYieldList(param1:String) : Array
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:XMLList = var_1560.elements("menu");
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length())
         {
            if(HabboToolbarIconEnum[_loc3_[_loc5_].@id] == param1)
            {
               _loc4_ = _loc3_[_loc5_].elements("yield");
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length())
               {
                  _loc2_.push(HabboToolbarIconEnum[_loc4_[_loc6_].@id]);
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
