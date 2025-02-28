-- merge_comment.lua
local function filter(input, env)
    for cand in input:iter() do
        local comment_parts = {}

        -- 获取原始注释（如部件拆字）
        local original_comment = cand.comment
        if original_comment and original_comment ~= "" then
            table.insert(comment_parts, original_comment)
        end

        -- 检查是否为用户词典中的词，添加星号
        if cand:get_genuine().quality >= 99 then
            table.insert(comment_parts, "*")
        end

        -- 辅助码注释，假设 auxiliary_code 在 comment 或 custom_attr 中
        local aux_code = cand:get_genuine().custom_attr and cand:get_genuine().custom_attr.auxiliary_code
        if aux_code then
            table.insert(comment_parts, aux_code)
        end

        -- 合并注释
        cand.comment = table.concat(comment_parts, " ")
        yield(cand)
    end
end

return filter