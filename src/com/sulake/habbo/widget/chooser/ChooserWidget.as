package com.sulake.habbo.widget.chooser
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class ChooserWidget extends RoomWidgetBase
   {
       
      
      private var var_371:ChooserView;
      
      private var var_370:ChooserView;
      
      public function ChooserWidget(param1:IHabboWindowManager, param2:IAssetLibrary = null, param3:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         if(var_370 != null)
         {
            var_370.dispose();
            var_370 = null;
         }
         if(var_371 != null)
         {
            var_371.dispose();
            var_371 = null;
         }
         super.dispose();
      }
      
      private function onUpdateUserChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(var_371 == null || !var_371.isOpen())
         {
            return;
         }
         var _loc2_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.const_355);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetChooserContentEvent.const_452,onChooserContent);
         param1.addEventListener(RoomWidgetChooserContentEvent.const_453,onChooserContent);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onUpdateFurniChooser);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_614,onUpdateFurniChooser);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_244,onUpdateUserChooser);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_571,onUpdateUserChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetChooserContentEvent.const_452,onChooserContent);
         param1.removeEventListener(RoomWidgetChooserContentEvent.const_453,onChooserContent);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onUpdateFurniChooser);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_614,onUpdateFurniChooser);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_244,onUpdateUserChooser);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_571,onUpdateUserChooser);
      }
      
      private function onUpdateFurniChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(var_370 == null || !var_370.isOpen())
         {
            return;
         }
         var _loc2_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.const_425);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      public function choose(param1:int, param2:int) : void
      {
         var _loc3_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_682,param1,param2);
         messageListener.processWidgetMessage(_loc3_);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomWidgetChooserContentEvent.const_452:
               if(var_370 == null)
               {
                  var_370 = new ChooserView(this,"${widget.chooser.furni.title}");
               }
               if(var_370 == null)
               {
                  return;
               }
               var_370.populate(param1.items,param1.isAnyRoomController);
               break;
            case RoomWidgetChooserContentEvent.const_453:
               if(var_371 == null)
               {
                  var_371 = new ChooserView(this,"${widget.chooser.user.title}");
               }
               if(var_371 == null)
               {
                  return;
               }
               var_371.populate(param1.items,false);
               break;
         }
      }
   }
}
