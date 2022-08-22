const fetch = require("node-fetch-commonjs");
const dotenv = require("dotenv");
dotenv.config();

export const getMessages = async () => {
  const params = {
    query: `-hasmy::${process.env.REACTION_NAME}: "@${process.env.USER_NAME}"`,
  };
  const query = new URLSearchParams(params);
  const response = await fetch(
    `https://slack.com/api/search.messages?${query}`,
    {
      headers: {
        Authorization: "Bearer " + process.env.SLACK_USER_TOKEN,
      },
    }
  );
  const data = (await response.json()) as any;
  return data.messages.matches.map((m) => m.permalink).join("\n");
};

export const postMessages = async ({ text }: { text: string }) => {
  const params = {
    channel: process.env.SLACK_CHANNEL_ID,
    text,
  };
  const query = new URLSearchParams(params);
  const response = await fetch(
    `https://slack.com/api/chat.postMessage?${query}`,
    {
      headers: {
        Authorization: "Bearer " + process.env.SLACK_BOT_TOKEN,
      },
    }
  );
  const data = (await response.json()) as any;
  console.log(data);
};

exports.handler = async () => {
  const messages = await getMessages();
  await postMessages({
    text: messages || "🎉 すべてのメンションに対応しました",
  });
};
