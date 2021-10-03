package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class TagRenderer
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1181:Function;
      
      public function TagRenderer(param1:HabboNavigator, param2:Function = null)
      {
         super();
         _navigator = param1;
         var_1181 = param2;
      }
      
      public function refreshTags(param1:IWindowContainer, param2:Array) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("tags"));
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            refreshTag(_loc3_,_loc4_,param2[_loc4_]);
            _loc4_++;
         }
         var _loc5_:int = param1.width - _loc3_.x;
         Util.layoutChildrenInArea(_loc3_,_loc5_,14);
         _loc3_.height = Util.getLowestPoint(_loc3_);
         _loc3_.visible = param2.length > 0;
         Logger.log("REFRESHED TAGS: " + param2.length + ", " + _loc3_.visible + ", " + _loc3_);
      }
      
      private function refreshTagBg(param1:IWindowContainer, param2:Boolean) : void
      {
         refreshBgPiece(param1,"l",param2);
         refreshBgPiece(param1,"m",param2);
         refreshBgPiece(param1,"r",param2);
      }
      
      private function onTagClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:* = null;
         var _loc3_:IWindowContainer = param2 as IWindowContainer;
         if(_loc3_ == null)
         {
            Logger.log("Target not container: " + param2);
            return;
         }
         var _loc4_:ITextWindow = ITextWindow(_loc3_.findChildByName("txt"));
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            refreshTagBg(_loc3_,true);
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            refreshTagBg(_loc3_,false);
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc5_ = _loc4_.text;
            Logger.log("TAG CLICKED: " + _loc5_);
            _navigator.performTagSearch(_loc5_);
            if(var_1181 != null)
            {
               var_1181();
            }
         }
      }
      
      private function refreshBgPiece(param1:IWindowContainer, param2:String, param3:Boolean) : void
      {
         var _loc5_:* = null;
         var _loc4_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("bg_" + param2));
         if(_loc4_.tags[0] != "" + param3)
         {
            Logger.log("Redraw tag bg: " + param3);
            _loc4_.tags.splice(0,_loc4_.tags.length);
            _loc4_.tags.push("" + param3);
            _loc5_ = "tag_" + param2 + (!!param3 ? "_reactive" : "");
            _loc4_.bitmap = _navigator.getButtonImage(_loc5_);
            _loc4_.invalidate();
         }
      }
      
      public function refreshTag(param1:IWindowContainer, param2:int, param3:String) : void
      {
         var _loc6_:* = null;
         var _loc4_:String = "tag." + param2;
         var _loc5_:IWindowContainer = IWindowContainer(param1.getChildByName(_loc4_));
         if(param3 == null || param3 == "")
         {
            if(_loc5_ != null)
            {
               _loc5_.visible = false;
            }
         }
         else
         {
            if(_loc5_ == null)
            {
               _loc5_ = IWindowContainer(_navigator.getXmlWindow("iro_tag"));
               _loc5_.name = _loc4_;
               param1.addChild(_loc5_);
               _loc5_.procedure = onTagClick;
            }
            _loc6_ = ITextWindow(_loc5_.findChildByName("txt"));
            _loc6_.text = param3;
            _loc6_.width = _loc6_.textWidth + 5;
            _loc5_.width = _loc6_.width + 3;
            refreshTagBg(_loc5_,false);
            _loc5_.visible = true;
         }
      }
   }
}
