import { parseChangelog } from "./changelogParser.js";

const safeYml = (string) =>
	string.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n");

export function changelogToYml(changelog, login) {
	const author = changelog.author || login;
	const ymlLines = [];

	ymlLines.push(`author: "${safeYml(author)}"`);
	ymlLines.push(`delete-after: True`);
	ymlLines.push(`changes:`);

	for (const change of changelog.changes) {
		ymlLines.push(
			`  - ${change.type.changelogKey}: "${safeYml(change.description)}"`
		);
	}

	return ymlLines.join("\n");
}

export function changelogToJson(changelog, login) {
	const author = changelog.author || login;
	const changelog_json = {
		"author" : `${safeYml(author)}`,
		"delete-after" : true,
		"changes" : []
	};

	for (const change of changelog.changes) {
		const change_json = {
			[`${change.type.changelogKey}`] : `${safeYml(change.description)}`
		};
		changelog_json.changes.push(change_json);
	}

	return changelog_json;
}

export async function processAutoChangelog({ github, context }) {
	const changelog = parseChangelog(context.payload.pull_request.body);
	if (!changelog || changelog.changes.length === 0) {
		console.log("no changelog found");
		return;
	}

	const json = changelogToJson(
		changelog,
		context.payload.pull_request.user.login
	);

	github.rest.repos.createOrUpdateFileContents({
		owner: context.repo.owner,
		repo: context.repo.repo,
		path: `html/changelogs/AutoChangeLog-pr-${context.payload.pull_request.number}.json`,
		message: `Automatic changelog for PR #${context.payload.pull_request.number} [ci skip]`,
		content: Buffer.from(JSON.stringify(json)).toString("base64"),
	});
}
