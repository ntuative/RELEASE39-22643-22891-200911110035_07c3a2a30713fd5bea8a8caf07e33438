package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetFaqTextMessageComposer;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.help.SearchViewController;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqCategory;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.help.help.data.FaqItem;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FaqBrowseEntry extends SearchViewController implements IHelpViewController
   {
       
      
      private var var_208:FaqItem;
      
      public function FaqBrowseEntry(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:* = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:FaqIndex = main.getFaq();
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 != null)
         {
            var_208 = FaqItem(param1);
         }
         if(var_208 == null)
         {
            return;
         }
         if(true)
         {
            main.sendMessage(new GetFaqTextMessageComposer(var_208.questionId));
            return;
         }
         var _loc3_:FaqCategory = var_208.category;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = container.findChildByTag("faq_category_title") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = _loc3_.categoryTitle;
         }
         _loc4_ = container.findChildByTag("faq_question_text") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = var_208.questionText;
         }
         _loc4_ = container.findChildByTag("faq_answer_text") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.htmlText = hackHTML(var_208.answerText);
         }
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_.getItemByIndex(NaN);
         }
         _loc4_ = container.findChildByTag("help_faq_next_entry_title") as ITextWindow;
         if(_loc4_ != null)
         {
            if(_loc5_ != null)
            {
               _loc4_.text = _loc5_.questionText;
               _loc4_.procedure = windowProcedure;
            }
            else
            {
               _loc4_.text = "";
            }
         }
         _loc4_ = container.findChildByTag("help_faq_next_entry") as ITextWindow;
         if(_loc4_ != null)
         {
            if(_loc5_ != null)
            {
               _loc4_.text = "${help.button.faq.next.entry}";
            }
            else
            {
               _loc4_.text = "";
            }
         }
         super.update(param1);
      }
      
      private function stripHTML(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = param1;
         while(_loc2_.indexOf("<") > -1)
         {
            _loc3_ = _loc2_.indexOf(">");
            if(_loc3_ > -1)
            {
               _loc2_ = _loc2_.slice(0,_loc2_.indexOf("<")) + _loc2_.slice(_loc2_.indexOf(">") + 1,_loc2_.length);
            }
         }
         return _loc2_;
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "help_faq_back":
               if(var_208 != null)
               {
                  _loc3_ = var_208.category;
                  main.showUI(HabboHelpViewEnum.const_230);
                  main.tellUI(HabboHelpViewEnum.const_230,_loc3_);
               }
               break;
            case "help_faq_next_entry":
               if(getNextItem() != null)
               {
                  main.tellUI(HabboHelpViewEnum.const_188,getNextItem());
               }
               break;
            default:
               super.windowProcedure(param1,param2);
         }
      }
      
      private function hackHTML(param1:String) : String
      {
         var _loc4_:* = null;
         var _loc2_:String = param1;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length - 4)
         {
            _loc4_ = _loc2_.slice(_loc3_,_loc3_ + 4);
            if(_loc4_ == "<img")
            {
               _loc2_ = _loc2_.slice(0,_loc3_) + "<img checkPolicyFile=\"true\"" + _loc2_.slice(_loc3_ + 4,_loc2_.length);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function render() : void
      {
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("help_faq_entry") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
         super.render();
         if(var_208 != null)
         {
            update();
         }
      }
      
      private function getNextItem() : FaqItem
      {
         var _loc1_:FaqIndex = main.getFaq();
         if(_loc1_ == null || var_208 == null)
         {
            return null;
         }
         var _loc2_:FaqCategory = var_208.category;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getItemByIndex(NaN);
      }
   }
}
