import { createStore } from 'vuex'

const store = createStore({
    state () {
        return {
            isLoggedIn:false,
            authUser:{},
            showLoginModal: false,
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

    }
})

export default store

