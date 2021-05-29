export default function (to, from, next, store){
    if(store.state.isLoggedIn){
        next()
    }else{
        store.commit('toggleLoginModal', true)
        // alert("Make sure you are logged in before using chat application.✌ ✌ ✌ ✌")
        // next({name:"home"});
    }
}
