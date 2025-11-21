<script>
export default{
    data() {
        return {
            company_name:"Sahaza Group",
            topics:[
                {'name':'introduction','duration':5},
                {'name':'theorie','duration':15},
                {'name':'pratique','duration':63}
            ]
        }
    },
    computed: {
        durationSortedBuDurationDesc(){
            return this.topics.sort((a,b) => b.duration - a.duration)
        }
    },

    methods: {
        isMaxDuration(topic){
            return topic.duration == this.durationSortedBuDurationDesc[0].duration;
        }
    },
}
</script>

<template>
    <div>

        <ul>
            <li :class="{'maxDuration': isMaxDuration(topic)}" v-for="(topic,index) in durationSortedBuDurationDesc" :key="index"> {{ topic.name }} - {{ topic.duration }} mn </li>
        </ul>
    </div>
    </template>

<style scoped>
div{
    width: 100vw;
    display: flex;
    justify-content: center;

}
ul{
    width: 80%;
    padding: 0;
}
li.maxDuration{
    border: 2px solid blue;
}
</style>