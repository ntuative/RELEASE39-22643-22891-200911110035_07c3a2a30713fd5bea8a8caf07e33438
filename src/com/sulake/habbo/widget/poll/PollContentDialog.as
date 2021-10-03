package com.sulake.habbo.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ICheckBoxWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class PollContentDialog implements IPollDialog
   {
       
      
      private var _id:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var var_935:int = -1;
      
      private var var_636:Array;
      
      private var _window:IFrameWindow;
      
      private var var_282:IWindow;
      
      private var _widget:PollWidget;
      
      private var var_2085:String = "";
      
      public function PollContentDialog(param1:int, param2:String, param3:Array, param4:PollWidget)
      {
         var _loc6_:* = null;
         super();
         _id = param1;
         var_2085 = param2;
         var_636 = param3;
         _widget = param4;
         var _loc5_:XmlAsset = _widget.assets.getAssetByName("poll_question") as XmlAsset;
         if(_loc5_)
         {
            _window = _widget.windowManager.buildFromXML(_loc5_.content as XML) as IFrameWindow;
            _loc6_ = _window.findChildByName("poll_question_headline") as ITextWindow;
            if(_loc6_)
            {
               _loc6_.text = param2;
            }
            _window.center();
            _window.procedure = windowEventProc;
            nextQuestion();
         }
      }
      
      private function populateSelectionList(param1:Array, param2:IWindowContainer) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:IItemListWindow = param2.findChildByName("poll_answer_itemlist") as IItemListWindow;
         if(_loc3_)
         {
            _loc4_ = param2.findChildByName("poll_answer_entity") as IWindowContainer;
            if(_loc4_)
            {
               _loc5_ = 0;
               while(true)
               {
                  _loc6_ = _loc4_.findChildByName("poll_answer_entity_text") as ITextWindow;
                  if(_loc6_)
                  {
                     _loc6_.text = param1[_loc5_];
                  }
                  _loc7_ = _loc4_.findChildByTag("POLL_SELECTABLE_ITEM");
                  if(_loc7_)
                  {
                     _loc7_.id = _loc5_;
                  }
                  _loc5_++;
                  if(_loc5_ >= param1.length)
                  {
                     break;
                  }
                  _loc4_ = _loc4_.clone() as IWindowContainer;
                  _loc3_.addListItem(_loc4_);
               }
            }
         }
      }
      
      private function populateCheckBoxType(param1:IWindowContainer, param2:Array) : void
      {
         var _loc3_:XmlAsset = _widget.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_checkbox_input\"!");
         }
         var _loc4_:IWindowContainer = _widget.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         if(_loc4_)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function populateRadionButtonType(param1:IWindowContainer, param2:Array) : void
      {
         var _loc3_:XmlAsset = _widget.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_radiobutton_input\"!");
         }
         var _loc4_:IWindowContainer = _widget.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         if(_loc4_)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function hideCancelConfirm() : void
      {
         if(var_282)
         {
            var_282.dispose();
            var_282 = null;
         }
      }
      
      private function resolveTextLineTypeAnswer() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         if(_window)
         {
            _loc2_ = _window.findChildByName("poll_answer_input") as ITextWindow;
            if(_loc2_)
            {
               _loc1_.push(_loc2_.text);
            }
            return _loc1_;
         }
         throw new Error("Invalid or disposed poll dialog!");
      }
      
      private function cancelConfirmEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "header_button_close":
                  hideCancelConfirm();
                  break;
               case "poll_cancel_confirm_button_cancel":
                  hideCancelConfirm();
                  break;
               case "poll_cancel_confirm_button_ok":
                  hideCancelConfirm();
                  cancelPoll();
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(!_disposed)
         {
            if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
               switch(param2.name)
               {
                  case "header_button_close":
                     showCancelConfirm();
                     break;
                  case "poll_question_button_ok":
                     answerPollQuestion();
                     break;
                  case "poll_question_cancel":
                     showCancelConfirm();
               }
            }
         }
      }
      
      private function cancelPoll() : void
      {
         _widget.pollCancelled(_id);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function resolveCheckBoxTypeAnswer() : Array
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:Array = new Array();
         if(_window)
         {
            _loc2_ = _window.findChildByName("poll_answer_itemlist") as IItemListWindow;
            if(_loc2_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.numListItems)
               {
                  _loc4_ = _loc2_.getListItemAt(_loc3_) as IWindowContainer;
                  if(_loc4_)
                  {
                     _loc5_ = _loc4_.findChildByName("poll_answer_checkbox") as ICheckBoxWindow;
                     if(_loc5_)
                     {
                        if(_loc5_.testStateFlag(WindowState.const_44))
                        {
                           _loc1_.push(_loc3_ + 1);
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
         return _loc1_;
      }
      
      private function resolveRadionButtonTypeAnswer() : Array
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = new Array();
         if(_window)
         {
            _loc2_ = _window.findChildByName("poll_aswer_selector") as ISelectorWindow;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getSelected();
               if(_loc3_)
               {
                  _loc1_.push(_loc3_.id + 1);
               }
            }
         }
         return _loc1_;
      }
      
      private function answerPollQuestion() : void
      {
         var answerArray:Array = null;
         var question:Dictionary = var_636[var_935] as Dictionary;
         var type:int = question["type"] as int;
         switch(type)
         {
            case 1:
               answerArray = resolveRadionButtonTypeAnswer();
               if(answerArray.length < int(question["selection_min"]))
               {
                  _widget.windowManager.alert("${win_error}","${poll_alert_answer_missing}",0,function(param1:IAlertDialog, param2:Event):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               if(answerArray.length > int(question["selection_max"]))
               {
                  _widget.windowManager.alert("${win_error}","${poll_alert_invalid_selection}",0,function(param1:IAlertDialog, param2:Event):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               break;
            case 2:
               answerArray = resolveCheckBoxTypeAnswer();
               if(answerArray.length < int(question["selection_min"]))
               {
                  _widget.windowManager.alert("${win_error}","${poll_alert_answer_missing}",0,function(param1:IAlertDialog, param2:Event):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               if(answerArray.length > int(question["selection_max"]))
               {
                  _widget.windowManager.alert("${win_error}","${poll_alert_invalid_selection}",0,function(param1:IAlertDialog, param2:Event):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               break;
            case 3:
               answerArray = resolveTextLineTypeAnswer();
               break;
            case 4:
               answerArray = resolveTextAreaTypeAnswer();
               break;
            default:
               throw new Error("Unknown poll question type: " + type + "!");
         }
         var message:RoomWidgetPollMessage = new RoomWidgetPollMessage(RoomWidgetPollMessage.ANSWER,_id);
         message.questionId = question["id"] as int;
         message.answers = answerArray;
         _widget.messageListener.processWidgetMessage(message);
         nextQuestion();
      }
      
      private function resolveTextAreaTypeAnswer() : Array
      {
         return resolveTextLineTypeAnswer();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            if(var_282)
            {
               var_282.dispose();
               var_282 = null;
            }
            _widget = null;
            var_636 = null;
            _disposed = true;
         }
      }
      
      private function showCancelConfirm() : void
      {
         var _loc1_:* = null;
         if(!var_282)
         {
            _loc1_ = _widget.assets.getAssetByName("poll_cancel_confirm") as XmlAsset;
            var_282 = _widget.windowManager.buildFromXML(_loc1_.content as XML,2);
            var_282.center();
            var_282.procedure = cancelConfirmEventProc;
         }
      }
      
      private function nextQuestion() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         ++var_935;
         if(var_935 < var_636.length)
         {
            _loc1_ = var_636[var_935] as Dictionary;
            if(!_loc1_)
            {
               Logger.log("ERROR; Poll question index out of range!");
            }
            if(_window)
            {
               _loc3_ = _loc1_["type"] as int;
               _loc2_ = _window.findChildByName("poll_question_text") as ITextWindow;
               if(_loc2_)
               {
                  _loc2_.text = _loc1_["content"];
               }
               _loc2_ = _window.findChildByName("poll_question_number") as ITextWindow;
               if(_loc2_)
               {
                  _loc2_.text = "${poll_question_number}";
                  _loc6_ = _loc2_.text;
                  _loc6_ = _loc6_.replace("%number%",_loc1_["number"]);
                  _loc6_ = _loc6_.replace("%count%",var_636.length);
                  _loc2_.text = _loc6_;
               }
               _loc4_ = _window.findChildByName("poll_question_answer_container") as IWindowContainer;
               if(_loc4_)
               {
                  while(_loc4_.numChildren > 0)
                  {
                     _loc4_.getChildAt(0).dispose();
                  }
               }
               switch(_loc3_)
               {
                  case 1:
                     populateRadionButtonType(_loc4_,_loc1_["selections"]);
                     break;
                  case 2:
                     populateCheckBoxType(_loc4_,_loc1_["selections"]);
                     break;
                  case 3:
                     method_6(_loc4_);
                     break;
                  case 4:
                     populateTextAreaType(_loc4_);
                     break;
                  default:
                     throw new Error("Unknown poll question type: " + _loc3_ + "!");
               }
               _loc5_ = _window.findChildByName("poll_content_wrapper") as IItemListWindow;
               if(_loc5_)
               {
                  _loc7_ = _loc5_.scrollableRegion.height - _loc5_.visibleRegion.height;
                  _window.height += _loc7_;
                  _window.center();
               }
            }
         }
         else
         {
            _widget.pollFinished(_id);
         }
      }
      
      private function method_6(param1:IWindowContainer) : void
      {
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("poll_answer_text_input") as XmlAsset;
         if(!_loc2_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_text_input\"!");
         }
         param1.addChild(_widget.windowManager.buildFromXML(_loc2_.content as XML));
      }
      
      private function populateTextAreaType(param1:IWindowContainer) : void
      {
         method_6(param1);
      }
   }
}
