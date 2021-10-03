package com.sulake.habbo.catalog.recycler
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PrizeViewer implements IGetImageListener
   {
       
      
      private var var_232:IBitmapWrapperWindow;
      
      public function PrizeViewer()
      {
         super();
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(var_232 == null || false)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         var_232.bitmap = new BitmapData(var_232.width,var_232.height,true,16777215);
         var_232.bitmap.fillRect(var_232.bitmap.rect,16777215);
         var _loc2_:Point = new Point((0 - param1.width) / 2,(0 - param1.height) / 2);
         var_232.bitmap.copyPixels(param1,param1.rect,_loc2_,null,null,true);
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setPreviewImage(param2);
      }
      
      public function viewProduct(param1:IRoomEngine, param2:IWindowContainer, param3:String, param4:int, param5:String, param6:String, param7:String = "") : void
      {
         var _loc8_:* = null;
         var_232 = param2.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         switch(param3)
         {
            case ProductTypeEnum.const_154:
               _loc8_ = param1.getFurnitureImage(param4,new Vector3d(90,0,0),64,this);
               break;
            case ProductTypeEnum.const_127:
               _loc8_ = param1.getWallItemImage(param4,new Vector3d(90,0,0),64,this,param7);
               break;
            default:
               return;
         }
         if(_loc8_ != null)
         {
            setPreviewImage(_loc8_.data);
         }
         var _loc9_:ITextWindow = param2.findChildByName("ctlg_product_name") as ITextWindow;
         if(_loc9_ != null)
         {
            _loc9_.text = param5;
         }
         _loc9_ = param2.findChildByName("ctlg_description") as ITextWindow;
         if(_loc9_ != null)
         {
            _loc9_.text = param6;
         }
      }
      
      public function dispose() : void
      {
         var_232 = null;
      }
   }
}
