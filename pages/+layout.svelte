<script>
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components'
	import '@evidence-dev/tailwind/fonts.css'
	import '../app.css'
	export let data;
</script>

<EvidenceDefaultLayout {data} fullWidth=true xProfile="https://x.com/oxon3f3">
	<slot slot="content" />
</EvidenceDefaultLayout>
