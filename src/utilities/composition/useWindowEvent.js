import {onBeforeUnmount, onMounted} from "vue";

export default function useWindowEvent(eventName, handleEvent){
    onMounted(()=>window.addEventListener(eventName, handleEvent))

    onBeforeUnmount(()=>window.removeEventListener(eventName, handleEvent))
}
