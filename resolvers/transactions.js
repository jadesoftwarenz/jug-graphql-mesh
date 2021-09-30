const resolvers = {
  FCAccount: {
    transactions: async (root, args, context, info) => {
      return [];
      //   const { items } =
      //     await context.Wiki.Query.getMetricsPageviewsAggregateProjectAccessAgentGranularityStartEnd(
      //       {
      //         root,
      //         args: {
      //           access: "all-access",
      //           agent: "user",
      //           end: moment().format("YYYYMMDD"),
      //           start: moment()
      //             .startOf("month")
      //             .subtract(1, "month")
      //             .format("YYYYMMDD"),
      //           project: args.project,
      //           granularity: "monthly",
      //         },
      //         context,
      //         info,
      //         selectionSet: /* GraphQL */ `
      //           {
      //             views
      //           }
      //         `,
      //       }
      //     );

      //   if (!items || items.length === 0) {
      //     return 0;
      //   }

      //   return items[0].views;
    },
  },
};

module.exports = { resolvers };
