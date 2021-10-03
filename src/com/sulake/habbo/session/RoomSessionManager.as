package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.handler.AvatarEffectsHandler;
   import com.sulake.habbo.session.handler.BaseHandler;
   import com.sulake.habbo.session.handler.GenericErrorHandler;
   import com.sulake.habbo.session.handler.LidoHandler;
   import com.sulake.habbo.session.handler.PlaceObjectErrorHandler;
   import com.sulake.habbo.session.handler.PollHandler;
   import com.sulake.habbo.session.handler.PresentHandler;
   import com.sulake.habbo.session.handler.RoomChatHandler;
   import com.sulake.habbo.session.handler.RoomDataHandler;
   import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
   import com.sulake.habbo.session.handler.RoomPermissionsHandler;
   import com.sulake.habbo.session.handler.RoomSessionHandler;
   import com.sulake.habbo.session.handler.RoomUsersHandler;
   import com.sulake.habbo.session.handler.TeleportErrorHandler;
   import com.sulake.habbo.session.handler.VoteHandler;
   import com.sulake.iid.IIDHabboCommunicationManager;
   
   public class RoomSessionManager extends Component implements IRoomSessionManager, IRoomHandlerListener
   {
       
      
      private var _connection:IConnection = null;
      
      private var var_89:Array = null;
      
      private var var_1834:int = 0;
      
      private var var_1120:String = "";
      
      private var var_676:Boolean = false;
      
      private var _communication:IHabboCommunicationManager = null;
      
      private var var_1121:Boolean = false;
      
      private var var_1833:Boolean = false;
      
      private var var_1835:Boolean = false;
      
      private var var_752:Boolean = false;
      
      private var var_191:Map = null;
      
      public function RoomSessionManager(param1:IContext, param2:uint = 0)
      {
         super(param1,param2);
         var_89 = [];
         var_191 = new Map();
         queueInterface(new IIDHabboCommunicationManager(),communicationReady);
      }
      
      public function gotoRoom(param1:Boolean, param2:int, param3:String = "", param4:String = "") : Boolean
      {
         if(!initialized)
         {
            var_1121 = true;
            var_1833 = param1;
            var_1834 = param2;
            var_1120 = param3;
            return false;
         }
         var _loc5_:int = 0;
         if(param1)
         {
            _loc5_ = 1;
         }
         var _loc6_:String = getRoomIdentifier(param2,_loc5_);
         var_752 = true;
         if(var_191.getValue(_loc6_) != null)
         {
            disposeSession(param2,_loc5_);
         }
         var _loc7_:RoomSession = new RoomSession(param2,_loc5_,param3,param4);
         _loc7_.connection = _connection;
         var_191.add(_loc6_,_loc7_);
         name_1.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_321,_loc7_));
         return true;
      }
      
      private function initializeManager() : void
      {
         if(_communication != null)
         {
            var_676 = true;
         }
         if(initialized && var_1121)
         {
            gotoRoom(var_1833,var_1834,var_1120);
            var_1121 = false;
            var_1120 = "";
         }
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            _connection = param1;
            createHandlers();
            initializeManager();
         }
      }
      
      public function set roomEngineReady(param1:Boolean) : void
      {
         var_1835 = param1;
         initializeManager();
      }
      
      public function get initialized() : Boolean
      {
         if(var_676 && var_1835)
         {
            return true;
         }
         return false;
      }
      
      private function updateHandlers(param1:IRoomSession) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1 != null && var_89 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_89.length)
            {
               _loc3_ = var_89[_loc2_] as BaseHandler;
               if(_loc3_ != null)
               {
                  _loc3_._xxxRoomId = param1.roomId;
                  _loc3_.var_51 = param1.roomCategory;
               }
               _loc2_++;
            }
         }
      }
      
      public function startSession(param1:IRoomSession) : Boolean
      {
         if(param1.state == RoomSessionEvent.const_86)
         {
            return false;
         }
         if(param1.start())
         {
            var_752 = false;
            name_1.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_86,param1));
            updateHandlers(param1);
            return true;
         }
         disposeSession(param1.roomId,param1.roomCategory);
         var_752 = false;
         return false;
      }
      
      private function createHandlers() : void
      {
         if(_connection == null)
         {
            return;
         }
         var_89.push(new RoomSessionHandler(_connection,this));
         var_89.push(new RoomChatHandler(_connection,this));
         var_89.push(new RoomUsersHandler(_connection,this));
         var_89.push(new RoomPermissionsHandler(_connection,this));
         var_89.push(new AvatarEffectsHandler(_connection,this));
         var_89.push(new RoomDataHandler(_connection,this));
         var_89.push(new PresentHandler(_connection,this));
         var_89.push(new PlaceObjectErrorHandler(_connection,this));
         var_89.push(new TeleportErrorHandler(_connection,this));
         var_89.push(new GenericErrorHandler(_connection,this));
         var_89.push(new PollHandler(_connection,this));
         var_89.push(new VoteHandler(_connection,this));
         var_89.push(new LidoHandler(_connection,this));
         var_89.push(new RoomDimmerPresetsHandler(_connection,this));
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         super.dispose();
         if(_communication != null)
         {
            release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         _connection = null;
         if(var_191)
         {
            while(false)
            {
               _loc1_ = var_191.getKey(0) as String;
               _loc2_ = var_191.remove(_loc1_) as RoomSession;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            var_191.dispose();
            var_191 = null;
         }
         if(var_89)
         {
            _loc3_ = 0;
            while(_loc3_ < var_89.length)
            {
               _loc4_ = var_89[_loc3_] as IDisposable;
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
               _loc3_++;
            }
            var_89 = null;
         }
      }
      
      private function getRoomIdentifier(param1:int, param2:int) : String
      {
         return "hard_coded_room_id";
      }
      
      private function communicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _communication = param2 as IHabboCommunicationManager;
         if(_communication != null)
         {
            _connection = _communication.getHabboMainConnection(onConnectionReady);
            if(_connection != null)
            {
               onConnectionReady(_connection);
            }
         }
      }
      
      public function getSession(param1:int, param2:int) : IRoomSession
      {
         var _loc3_:String = getRoomIdentifier(param1,param2);
         return var_191.getValue(_loc3_) as IRoomSession;
      }
      
      public function get sessionStarting() : Boolean
      {
         return var_752;
      }
      
      public function sessionReinitialize(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc7_:* = null;
         var _loc5_:String = getRoomIdentifier(param1,param2);
         var _loc6_:RoomSession = var_191.remove(_loc5_) as RoomSession;
         if(_loc6_ != null)
         {
            param4 = param2;
            _loc6_.reset(param3,param4);
            _loc5_ = getRoomIdentifier(param3,param4);
            _loc7_ = var_191.remove(_loc5_);
            if(_loc7_ != null)
            {
            }
            var_191.add(_loc5_,_loc6_);
            updateHandlers(_loc6_);
         }
      }
      
      public function disposeSession(param1:int, param2:int) : void
      {
         var _loc3_:String = getRoomIdentifier(param1,param2);
         var _loc4_:RoomSession = var_191.remove(_loc3_) as RoomSession;
         if(_loc4_ != null)
         {
            name_1.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_97,_loc4_));
            _loc4_.dispose();
         }
      }
      
      public function sessionUpdate(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:IRoomSession = getSession(param1,param2);
         if(_loc4_ != null)
         {
            switch(param3)
            {
               case RoomSessionHandler.const_760:
                  break;
               case RoomSessionHandler.const_768:
                  break;
               case RoomSessionHandler.const_491:
                  disposeSession(param1,param2);
            }
         }
      }
   }
}
