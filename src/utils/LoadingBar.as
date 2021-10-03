package utils
{
   import com.sulake.core.runtime.ICoreConfigStatusListener;
   import flash.display.Sprite;
   
   public class LoadingBar extends Sprite implements ICoreConfigStatusListener
   {
       
      
      protected var _disposed:Boolean = false;
      
      private var _height:int = 20;
      
      private var _width:int = 200;
      
      private var var_18:Number = 0;
      
      private var var_20:int = 16777215;
      
      private var var_19:int = 2500143;
      
      private var var_6:Sprite;
      
      private var var_17:int = 1;
      
      private var var_3:Sprite;
      
      private var var_13:int = 1;
      
      public function LoadingBar()
      {
         super();
         updateBorder();
         updateBar();
      }
      
      public function set percent(param1:Number) : void
      {
         var_18 = param1;
         updateBar();
      }
      
      private function updateBorder() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_6 == null)
         {
            var_6 = new Sprite();
            addChild(var_6);
         }
         var_6.graphics.lineStyle(var_13,var_20);
         var_6.graphics.beginFill(var_19);
         var_6.graphics.drawRect(1,0,_width - 1,0);
         var_6.graphics.drawRect(_width,1,0,_height - 1);
         var_6.graphics.drawRect(1,_height,_width - 1,0);
         var_6.graphics.drawRect(0,1,0,_height - 1);
         var_6.graphics.endFill();
      }
      
      private function updateBar() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_3 == null)
         {
            var_3 = new Sprite();
            addChild(var_3);
            var_3.x = var_13 + var_17;
            var_3.y = var_13 + var_17;
         }
         var_3.graphics.clear();
         var _loc1_:int = _height - var_13 * 2 - var_17 * 2;
         var _loc2_:int = (_width - var_13 * 2 - var_17 * 2) * var_18;
         var_3.graphics.beginFill(12241619);
         var_3.graphics.drawRect(0,0,_loc2_,_loc1_ / 2);
         var_3.graphics.endFill();
         var_3.graphics.beginFill(9216429);
         var_3.graphics.drawRect(0,_loc1_ / 2,_loc2_,_loc1_ / 2 + 1);
         var_3.graphics.endFill();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
