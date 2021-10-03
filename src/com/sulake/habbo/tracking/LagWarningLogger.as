package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.utils.getTimer;
   
   public class LagWarningLogger
   {
      
      public static const const_816:int = 0;
      
      public static const WARNING_TYPE_CHAT_DELAY:int = 1;
       
      
      private var var_1380:int = 0;
      
      private var var_919:int = 0;
      
      private var var_920:int = 0;
      
      private var var_1134:int = 0;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_1135:int = 15;
      
      private var var_160:IHabboConfigurationManager;
      
      private var _connection:IConnection;
      
      private var var_1133:int = 60;
      
      public function LagWarningLogger()
      {
         super();
         var_1134 = getTimer();
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
      }
      
      public function update(param1:uint) : void
      {
         if(getTimer() - var_1134 > var_1133 * 1000 && var_1380 < var_1135)
         {
            var_1134 = getTimer();
            logWarnings();
         }
      }
      
      private function resetLog() : void
      {
         var_919 = 0;
         var_920 = 0;
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         var_160 = param1;
         var_1133 = int(var_160.getKey("lagwarninglog.interval","60"));
         var_1135 = int(var_160.getKey("lagwarninglog.reportlimit","15"));
      }
      
      public function registerWarning(param1:int) : void
      {
         switch(param1)
         {
            case WARNING_TYPE_CHAT_DELAY:
               var_920 += 1;
            case const_816:
               var_919 += 1;
         }
      }
      
      public function logWarnings() : void
      {
         var _loc1_:LagWarningReportMessageComposer = new LagWarningReportMessageComposer(var_919,var_920);
         if(_connection != null)
         {
            _connection.send(_loc1_);
         }
         resetLog();
         ++var_1380;
      }
      
      public function set connection(param1:IConnection) : void
      {
         _connection = param1;
      }
   }
}
