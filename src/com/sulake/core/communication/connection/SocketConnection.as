package com.sulake.core.communication.connection
{
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.messages.IMessageClassManager;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.communication.messages.MessageClassManager;
   import com.sulake.core.communication.messages.MessageDataWrapper;
   import com.sulake.core.communication.protocol.IProtocol;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.ErrorReportStorage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class SocketConnection extends EventDispatcher implements IConnection, IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_193:Socket;
      
      private var var_632:IEncryption;
      
      private var var_255:ByteArray;
      
      private var var_256:ErrorReportStorage;
      
      private var _id:String;
      
      private var var_735:ICoreCommunicationManager;
      
      private var var_443:Timer;
      
      private var var_520:IProtocol;
      
      private var var_777:IMessageClassManager;
      
      public function SocketConnection(param1:String, param2:ICoreCommunicationManager)
      {
         super();
         _id = param1;
         var_735 = param2;
         var_255 = new ByteArray();
         var_777 = new MessageClassManager();
         var_193 = new Socket();
         var_443 = new Timer(5000,1);
         var_443.addEventListener(TimerEvent.TIMER,onTimeOutTimer);
         var_193.addEventListener(Event.CONNECT,onConnect);
         var_193.addEventListener(Event.COMPLETE,onComplete);
         var_193.addEventListener(Event.CLOSE,onClose);
         var_193.addEventListener(ProgressEvent.SOCKET_DATA,onRead);
         var_193.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         var_193.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
      }
      
      public function sendRaw(param1:ByteArray, param2:Boolean = true) : Boolean
      {
         if(var_632 != null)
         {
            if(!param2)
            {
            }
         }
         return false;
      }
      
      private function onTimeOutTimer(param1:TimerEvent) : void
      {
         var_443.stop();
         Logger.log("[SocketConnection] TimeOut Error");
         var _loc2_:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
         _loc2_.text = "[Habbo] Socket Timeout Error (5000ms). Possible Firewall prevention.";
         dispatchEvent(_loc2_);
      }
      
      public function setEncryption(param1:IEncryption) : void
      {
         var_632 = param1;
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         var_443.stop();
         Logger.log("[SocketConnection] Security Error: " + param1.text);
         dispatchEvent(param1);
      }
      
      private function onConnect(param1:Event) : void
      {
         Logger.log("[SocketConnection] Connected");
         var_443.stop();
         dispatchEvent(param1);
      }
      
      public function send(param1:IMessageComposer, param2:int = -1) : Boolean
      {
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = this.var_777.getMessageComposerID(param1);
         if(_loc4_ < 0)
         {
            Logger.log("Could not find registered message composer for " + param1);
            return false;
         }
         var _loc5_:ByteArray = var_520.encoder.encode(_loc4_,param1.getMessageArray(),param2);
         if(var_256)
         {
            var_256["last_sent_message_time"] = new Date().getTime();
            var_256["last_sent_message_data"] = _loc5_;
         }
         if(var_632 != null)
         {
            _loc3_ = var_632.encipher(_loc5_);
         }
         else
         {
            _loc3_ = _loc5_;
         }
         Logger.log("<< [SOCKET]: " + [_loc4_,param1.getMessageArray(),"->",_loc3_]);
         if(false)
         {
            var_193.writeBytes(_loc3_);
            var_193.flush();
            return true;
         }
         Logger.log("[SOCKET] Not connected.");
         return false;
      }
      
      public function init(param1:String, param2:uint = 0) : Boolean
      {
         if(var_256)
         {
            var_256["host_name"] = param1;
            var_256["host_port"] = param2;
         }
         Security.loadPolicyFile("xmlsocket://" + param1 + ":" + param2);
         var_443.start();
         var_193.connect(param1,param2);
         return true;
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         var_735.addConnectionMessageEvent(_id,param1);
      }
      
      private function onRead(param1:ProgressEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         while(false)
         {
            var_255.writeByte(var_193.readUnsignedByte());
         }
         Logger.log(">>[SOCKET]: " + var_255.toString());
         var _loc2_:Array = new Array();
         var _loc3_:uint = var_520.getMessages(var_255,_loc2_);
         var _loc4_:Number = new Date().getTime();
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = _loc5_[0] as int;
            _loc7_ = _loc5_[1] as ByteArray;
            if(var_256)
            {
               var_256["last_received_message_time"] = _loc4_;
               var_256["last_received_message_data"] = _loc6_ + " " + _loc7_;
            }
            Logger.log(">>[SocketConnection] Received message id: " + _loc6_ + " data: " + _loc7_.toString());
            _loc8_ = var_777.getMessageEventClasses(_loc6_);
            _loc9_ = new Array();
            for each(_loc10_ in _loc8_)
            {
               _loc12_ = var_735.getMessageEvents(this,_loc10_);
               _loc9_ = _loc9_.concat(_loc12_);
            }
            if(_loc9_.length == 0)
            {
               Logger.log(">>[SocketConnection] No message event listeners defined for id: " + _loc6_);
            }
            for each(_loc11_ in _loc9_)
            {
               _loc13_ = _loc11_.parserClass;
               if(_loc13_ == null)
               {
                  Logger.log(">>[SocketConnection] Message Event Has no parser defined, use annotation?: " + [_loc6_,_loc11_]);
               }
               else
               {
                  _loc14_ = new ByteArray();
                  _loc14_.writeBytes(_loc7_);
                  _loc14_.position = _loc7_.position;
                  _loc11_.connection = this;
                  _loc15_ = new MessageDataWrapper(_loc14_,protocol.decoder);
                  _loc16_ = var_735.getMessageParser(_loc13_);
                  if(!_loc16_.flush())
                  {
                     Logger.log(">>[SocketConnection] Message Event Parser wasn\'t flushed: " + [_loc6_,_loc13_,_loc16_]);
                  }
                  else if(_loc16_.parse(_loc15_))
                  {
                     _loc11_.parser = _loc16_;
                     _loc11_.callback.call(null,_loc11_);
                  }
                  else
                  {
                     Logger.log(">>[SocketConnection] Could not parse message: " + [_loc6_,_loc10_,_loc11_]);
                  }
               }
            }
         }
         if(_loc3_ == var_255.length)
         {
            var_255 = new ByteArray();
         }
         else if(_loc3_ > 0)
         {
            _loc17_ = new ByteArray();
            _loc17_.writeBytes(var_255,_loc3_);
            var_255 = _loc17_;
            Logger.log("[SOCKET REST] offset: " + _loc3_ + " rest: " + var_255.toString());
         }
      }
      
      public function get protocol() : IProtocol
      {
         return var_520;
      }
      
      public function set logger(param1:ErrorReportStorage) : void
      {
         var_256 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get logger() : ErrorReportStorage
      {
         return var_256;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         var_193 = null;
         var_255 = null;
         var_256 = null;
         var_632 = null;
         var_520 = null;
         _id = null;
         var_777 = null;
         var_735 = null;
      }
      
      public function set protocol(param1:IProtocol) : void
      {
         var_520 = param1;
      }
      
      public function registerMessageClasses(param1:IMessageConfiguration) : void
      {
         var_777.registerMessages(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         var_443.stop();
         Logger.log("[SocketConnection] Complete");
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         var_443.stop();
         Logger.log("[SocketConnection] IO Error: " + param1.text);
         switch(param1.type)
         {
            case IOErrorEvent.IO_ERROR:
               break;
            case IOErrorEvent.DISK_ERROR:
               break;
            case IOErrorEvent.NETWORK_ERROR:
               break;
            case IOErrorEvent.VERIFY_ERROR:
         }
         dispatchEvent(param1);
      }
      
      private function onClose(param1:Event) : void
      {
         var_443.stop();
         Logger.log("[SocketConnection] Closed");
         dispatchEvent(param1);
      }
      
      override public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ += "Socket Connection: \n";
         _loc1_ += "Protocol Encoder: undefined\n";
         _loc1_ += "Protocol Decoder: undefined\n";
         return _loc1_ + ("Encryption: " + var_632 + "\n");
      }
   }
}
