package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class PurseCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
       
      
      public function PurseCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = ["vouchers_btn","coins_btn"];
         for each(_loc2_ in _loc1_)
         {
            _loc6_ = _window.findChildByName(_loc2_) as IButtonWindow;
            if(_loc6_ != null)
            {
               _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseClick);
            }
         }
         _loc3_ = _window.findChildByName("purse_info_tickets") as ITextWindow;
         _loc4_ = _window.findChildByName("purse_info_film") as ITextWindow;
         _loc5_ = _window.findChildByName("purse_amount") as ITextWindow;
         _loc5_.text = page.viewer.catalog.getPurse().credits.toString();
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         var element:IWindow = event.target as IWindow;
         var id:String = element.name;
         switch(id)
         {
            case "vouchers_btn":
               page.viewer.catalog.windowManager.alert("Purse Voucher","Vouchers clicked",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               break;
            case "coins_btn":
               page.viewer.catalog.windowManager.alert("Purse Credits","Credits clicked",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               break;
            default:
               Logger.log("PurseCatalogWidget: unknonwn button");
         }
      }
   }
}
