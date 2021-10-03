package utils
{
   import flash.display.Shape;
   import flash.events.Event;
   
   public class Background extends Shape
   {
       
      
      private var _color:uint;
      
      public function Background(param1:uint)
      {
         super();
         _color = param1;
         addEventListener(Event.ADDED_TO_STAGE,onStageInit);
         addEventListener(Event.REMOVED_FROM_STAGE,onStageRemove);
      }
      
      private function positionDisplayElements() : void
      {
         graphics.clear();
         graphics.beginFill(_color);
         graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
      }
      
      private function onResize(param1:Event) : void
      {
         if(param1.type == Event.RESIZE)
         {
            positionDisplayElements();
         }
      }
      
      private function onStageRemove(param1:Event = null) : void
      {
         stage.removeEventListener(Event.RESIZE,onResize);
      }
      
      private function onStageInit(param1:Event = null) : void
      {
         stage.addEventListener(Event.RESIZE,onResize);
         positionDisplayElements();
      }
   }
}
