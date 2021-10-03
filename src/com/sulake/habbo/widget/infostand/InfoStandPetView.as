package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class InfoStandPetView
   {
       
      
      private var _widget:InfostandWidget;
      
      private var var_110:IItemListWindow;
      
      private var var_210:IBorderWindow;
      
      private var _window:IItemListWindow;
      
      public function InfoStandPetView(param1:InfostandWidget, param2:String)
      {
         super();
         _widget = param1;
         createWindow(param2);
      }
      
      private function updateWindow() : void
      {
         if(var_110 == null || var_210 == null)
         {
            return;
         }
         var_110.height = var_110.scrollableRegion.height;
         var_210.height = NaN;
         _window.width = var_210.width;
         _window.height = _window.scrollableRegion.height;
         var_210.x = 0 - 0;
         _widget.refreshContainer();
      }
      
      public function update(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         name = param1.name;
         image = param1.image;
         age = param1.age;
         mood = param1.moodType;
         hunger = param1.hungerType;
         thirst = param1.thirstType;
         setNature(param1.natureTypeArray[0],param1.natureTypeArray[1]);
         var _loc2_:String = _widget.localizations.getKey(getRaceLocalizationKey(param1.petType,param1.petRace));
         description = _loc2_;
         updateWindow();
      }
      
      public function set image(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = var_110.getListItemByName("image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,param1.height,true,0);
         var _loc4_:Point = new Point((_loc2_.width - param1.width) / 2,0);
         _loc3_.copyPixels(param1,param1.rect,_loc4_);
         _loc2_.height = param1.height;
         _loc2_.bitmap = _loc3_;
         _loc2_.invalidate();
         updateWindow();
      }
      
      public function setNature(param1:int, param2:int) : void
      {
         var _loc3_:IWindowContainer = var_110.getListItemByName("pet_nature") as IWindowContainer;
         var _loc4_:ITextWindow = _loc3_.getChildByName("nature_value") as ITextWindow;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.text = _widget.localizations.getKey("pet.enrg." + param1) + ", \n" + _widget.localizations.getKey("pet.frnd." + param2);
         _loc4_.height = _loc4_.textHeight + 5;
         _loc3_.height = _loc4_.height;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("pet_view") as XmlAsset;
         _window = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_210 = _window.getListItemByName("info_border") as IBorderWindow;
         if(var_210 != null)
         {
            var_110 = var_210.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         _widget.mainContainer.addChild(_window);
         var _loc3_:IWindow = var_210.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onClose);
         }
      }
      
      public function set age(param1:int) : void
      {
         var _loc2_:IWindowContainer = var_110.getListItemByName("pet_age") as IWindowContainer;
         var _loc3_:ITextWindow = _loc2_.getChildByName("age_value") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = String(param1);
         _loc2_.height = _loc3_.textHeight + 5;
      }
      
      public function set mood(param1:int) : void
      {
         var _loc2_:IWindowContainer = var_110.getListItemByName("pet_mood") as IWindowContainer;
         var _loc3_:ITextWindow = _loc2_.getChildByName("mood_value") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = String(_widget.localizations.getKey("pet.mood." + param1));
         _loc2_.height = _loc3_.textHeight + 5;
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      public function set hunger(param1:int) : void
      {
         var _loc2_:IWindowContainer = var_110.getListItemByName("pet_hunger") as IWindowContainer;
         var _loc3_:ITextWindow = _loc2_.getChildByName("hunger_value") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = String(_widget.localizations.getKey("pet.hunger." + param1));
         _loc2_.height = _loc3_.textHeight + 5;
      }
      
      private function getRaceLocalizationKey(param1:int, param2:int) : String
      {
         var _loc3_:String = "";
         if(param2 < 10)
         {
            _loc3_ = "00" + param2;
         }
         else if(param2 < 100)
         {
            _loc3_ = "0" + param2;
         }
         return "pet.race." + param1 + "." + _loc3_;
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:ITextWindow = var_110.getListItemByName("description_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         _widget.close();
      }
      
      public function set thirst(param1:int) : void
      {
         var _loc2_:IWindowContainer = var_110.getListItemByName("pet_thirst") as IWindowContainer;
         var _loc3_:ITextWindow = _loc2_.getChildByName("thirst_value") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = _widget.localizations.getKey("pet.thirst." + param1);
         _loc2_.height = _loc3_.textHeight + 5;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:ITextWindow = var_110.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      public function dispose() : void
      {
         _widget = null;
         _window.dispose();
         _window = null;
      }
   }
}
