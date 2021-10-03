package com.sulake.habbo.navigator.roomthumbnails
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class ThumbnailImageConfigurations
   {
       
      
      private var var_1352:Dictionary;
      
      private var var_1899:BitmapData;
      
      private var var_1353:Dictionary;
      
      private var _navigator:HabboNavigator;
      
      public function ThumbnailImageConfigurations(param1:HabboNavigator)
      {
         var_1353 = new Dictionary();
         var_1352 = new Dictionary();
         super();
         _navigator = param1;
         this.var_1899 = this._navigator.getButtonImage("rico_selected");
         addImg(1,ThumbnailEditorModel.const_33,"rico_bg1");
         addImg(2,ThumbnailEditorModel.const_33,"rico_bg2");
         addImg(3,ThumbnailEditorModel.const_33,"rico_bg3");
         addImg(4,ThumbnailEditorModel.const_33,"rico_bg4");
         addImg(5,ThumbnailEditorModel.const_33,"rico_bg5");
         addImg(6,ThumbnailEditorModel.const_33,"rico_bg6");
         addImg(7,ThumbnailEditorModel.const_33,"rico_bg7");
         addImg(8,ThumbnailEditorModel.const_33,"rico_bg8");
         addImg(9,ThumbnailEditorModel.const_33,"rico_bg9");
         addImg(10,ThumbnailEditorModel.const_33,"rico_bg10");
         addImg(11,ThumbnailEditorModel.const_33,"rico_bg11");
         addImg(12,ThumbnailEditorModel.const_33,"rico_bg12");
         addImg(13,ThumbnailEditorModel.const_33,"rico_bg13");
         addImg(14,ThumbnailEditorModel.const_33,"rico_bg14");
         addImg(15,ThumbnailEditorModel.const_33,"rico_bg15");
         addImg(16,ThumbnailEditorModel.const_33,"rico_bg16");
         addImg(17,ThumbnailEditorModel.const_33,"rico_bg17");
         addImg(18,ThumbnailEditorModel.const_33,"rico_bg18");
         addImg(19,ThumbnailEditorModel.const_33,"rico_bg19");
         addImg(20,ThumbnailEditorModel.const_33,"rico_bg20");
         addImg(22,ThumbnailEditorModel.const_33,"rico_bg22");
         addImg(23,ThumbnailEditorModel.const_33,"rico_bg23");
         addImg(24,ThumbnailEditorModel.const_33,"rico_bg24");
         addImg(0,ThumbnailEditorModel.const_48,"rico_top0");
         addImg(1,ThumbnailEditorModel.const_48,"rico_top1");
         addImg(2,ThumbnailEditorModel.const_48,"rico_top2");
         addImg(3,ThumbnailEditorModel.const_48,"rico_top3");
         addImg(4,ThumbnailEditorModel.const_48,"rico_top4");
         addImg(5,ThumbnailEditorModel.const_48,"rico_top5");
         addImg(6,ThumbnailEditorModel.const_48,"rico_top6");
         addImg(7,ThumbnailEditorModel.const_48,"rico_top7");
         addImg(8,ThumbnailEditorModel.const_48,"rico_top8");
         addImg(9,ThumbnailEditorModel.const_48,"rico_top9");
         addImg(10,ThumbnailEditorModel.const_48,"rico_top10");
         addImg(11,ThumbnailEditorModel.const_48,"rico_top11");
         addImg(0,ThumbnailEditorModel.const_31,"rico_ob0");
         addImg(1,ThumbnailEditorModel.const_31,"rico_ob1");
         addImg(2,ThumbnailEditorModel.const_31,"rico_ob2");
         addImg(3,ThumbnailEditorModel.const_31,"rico_ob3");
         addImg(4,ThumbnailEditorModel.const_31,"rico_ob4");
         addImg(5,ThumbnailEditorModel.const_31,"rico_ob5");
         addImg(6,ThumbnailEditorModel.const_31,"rico_ob6");
         addImg(7,ThumbnailEditorModel.const_31,"rico_ob7");
         addImg(8,ThumbnailEditorModel.const_31,"rico_ob8");
         addImg(9,ThumbnailEditorModel.const_31,"rico_ob9");
         addImg(10,ThumbnailEditorModel.const_31,"rico_ob10");
         addImg(11,ThumbnailEditorModel.const_31,"rico_ob11");
         addImg(12,ThumbnailEditorModel.const_31,"rico_ob12");
         addImg(13,ThumbnailEditorModel.const_31,"rico_ob13");
         addImg(14,ThumbnailEditorModel.const_31,"rico_ob14");
         addImg(15,ThumbnailEditorModel.const_31,"rico_ob15");
         addImg(16,ThumbnailEditorModel.const_31,"rico_ob16");
         addImg(17,ThumbnailEditorModel.const_31,"rico_ob17");
         addImg(18,ThumbnailEditorModel.const_31,"rico_ob18");
         addImg(19,ThumbnailEditorModel.const_31,"rico_ob19");
         addImg(20,ThumbnailEditorModel.const_31,"rico_ob20");
         addImg(21,ThumbnailEditorModel.const_31,"rico_ob21");
         addImg(22,ThumbnailEditorModel.const_31,"rico_ob22");
         addImg(23,ThumbnailEditorModel.const_31,"rico_ob23");
         addImg(24,ThumbnailEditorModel.const_31,"rico_ob24");
         addImg(25,ThumbnailEditorModel.const_31,"rico_ob25");
         addImg(26,ThumbnailEditorModel.const_31,"rico_ob26");
         addImg(27,ThumbnailEditorModel.const_31,"rico_ob27");
      }
      
      private function addImg(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:ThumbnailImageConfiguration = new ThumbnailImageConfiguration(_navigator,param1,param2,param3,var_1899);
         getImageList(param2).push(_loc4_);
         getImageMap(param2)[param1] = _loc4_;
      }
      
      public function getImageList(param1:int) : Array
      {
         var _loc2_:Array = this.var_1353[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Array();
            var_1353[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function getImage(param1:int, param2:int) : ThumbnailImageConfiguration
      {
         return this.getImageMap(param1)[param2];
      }
      
      private function getImageMap(param1:int) : Dictionary
      {
         var _loc2_:Dictionary = this.var_1352[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Dictionary();
            var_1352[param1] = _loc2_;
         }
         return _loc2_;
      }
   }
}
