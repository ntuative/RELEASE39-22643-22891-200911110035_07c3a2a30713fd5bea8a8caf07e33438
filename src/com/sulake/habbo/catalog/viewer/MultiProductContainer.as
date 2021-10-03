package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.room.IRoomEngine;
   
   public class MultiProductContainer extends SingleProductContainer implements IProductContainer
   {
       
      
      public function MultiProductContainer(param1:Offer, param2:Array)
      {
         super(param1,param2);
      }
      
      override public function initProductIcon(param1:IRoomEngine) : void
      {
         super.initProductIcon(param1);
         _view.findChildByName("multiContainer").visible = true;
         ITextWindow(_view.findChildByName("multiCounter")).text = "xundefined";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
