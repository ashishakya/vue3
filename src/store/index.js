import { createStore } from 'vuex'
import {UPDATE_GREET_MESSAGE} from "./mutation-types";

const store = createStore({
    state () {
        return {
            isLoggedIn:false,
            authUser:{},
            showLoginModal: false,
            greet: "hello from the state",
            user:{
                name:'ashish',
                age:25
            }
        }
    },
    mutations: {
        setLoggedInStatus(state, status){
            state.isLoggedIn = status
        },
        setAuthUser(state, authUser){
            state.authUser = authUser
        },
        toggleLoginModal(state, toggleStatus){
            state.showLoginModal=toggleStatus
        },
        [UPDATE_GREET_MESSAGE](state){
            state.greet = "Default greeting"
        }
    },
    getters:{
        userAge(state){
            return state.user.age
        }
    },
    actions:{
      resetGreetMessageWithAction: function ({commit}){
          console.log('action called');
          commit(UPDATE_GREET_MESSAGE)
      },
      asyncResetGreetMessageWithAction: function ({commit}){
            console.log('action with async called');
            setTimeout(function(){
                commit(UPDATE_GREET_MESSAGE)
            }, 2000)
      }
    }
})

export default store

